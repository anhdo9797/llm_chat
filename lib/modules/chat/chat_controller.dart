import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import '../../core/controllers/base_controller.dart';
import '../../data/repositories/chat_repository.dart';

class ChatController extends BaseController {
  final ChatRepository _chatRepository;
  String currentConversationId = '';
  String currentMessageId = '';
  StreamSubscription? _messageSubscription;

  ChatController({required ChatRepository chatRepository})
    : _chatRepository = chatRepository;
  final chatHistory =
      <String>[
        'AI Chat Tool Ethics',
        'AI Chat Tool Impact Writing',
        'New chat',
      ].obs;

  final selectedChatIndex = 0.obs;

  final messages = <String>[].obs;

  final messageText = ''.obs;

  @override
  void onInit() {
    log('ChatController initialized');
    super.onInit();
  }

  /// Create new chat
  void newChat() {
    messages.clear();
    selectedChatIndex.value = 0;
    chatHistory.insert(0, 'New chat');
  }

  void selectChat(int index) {
    selectedChatIndex.value = index;
  }

  void clearConversations() {
    chatHistory.clear();
    messages.clear();
    chatHistory.add('New chat');
    selectedChatIndex.value = 0;
  }

  void logout() {
    Get.offAllNamed('/login');
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    try {
      setLoading(true);
      messages.add("User: $text");

      // Cancel previous subscription if exists
      await _messageSubscription?.cancel();

      // Tạo message bot rỗng để hiển thị animation typing
      messages.add("Bot: ");
      final botMessageIndex = messages.length - 1;

      String botResponse = '';

      // Subscribe to message stream
      _messageSubscription = _chatRepository
          .sendMessage(
            query: text,
            conversationId: currentConversationId,
            user: 'user',
          )
          .listen(
            (chunk) {
              try {
                final jsonData = jsonDecode(chunk);

                // Xử lý conversation_id từ workflow_started event
                if (jsonData['event'] == 'workflow_started') {
                  currentConversationId = jsonData['conversation_id'] as String;
                  currentMessageId = jsonData['message_id'] as String;
                }

                // Xử lý message từ message event
                if (jsonData['event'] == 'message') {
                  final answer = jsonData['answer'] as String;
                  botResponse += answer;

                  // Update bot message với accumulated response
                  messages[botMessageIndex] = "Bot: $botResponse";
                }
              } catch (e) {
                print('Error parsing chunk: $e');
              }
            },
            onError: (error) {
              showError('Lỗi khi nhận phản hồi: $error');
            },
            onDone: () {
              messageText.value = '';
              setLoading(false);
            },
          );
    } catch (e) {
      showError('Không thể gửi tin nhắn: ${e.toString()}');
      setLoading(false);
    }
  }

  @override
  void onClose() {
    _messageSubscription?.cancel();
    super.onClose();
  }
}
