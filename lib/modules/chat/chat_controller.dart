import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/controllers/base_controller.dart';
import '../../data/models/conversation_model.dart';
import '../../data/models/message_history_model.dart';
import '../../data/repositories/chat_repository.dart';
import '../../services/storage_service.dart';

class ChatController extends BaseController {
  final ChatRepository _chatRepository;
  final StorageService _storageService = Get.find<StorageService>();
  String currentConversationId = '';
  String currentMessageId = '';
  StreamSubscription? _messageSubscription;

  // State quản lý dark/light mode
  final isDarkMode = false.obs;

  // State quản lý current user
  final currentUser = RxString('');

  ChatController({required ChatRepository chatRepository})
    : _chatRepository = chatRepository {
    // Load theme mode từ storage
    isDarkMode.value = Get.isDarkMode;

    // Load user từ storage
    final savedUser = _storageService.getString(StorageService.keyUser);
    if (savedUser != null) {
      currentUser.value = savedUser;
    }
  }
  // Quản lý conversations
  final conversations = <ConversationModel>[].obs;
  final selectedConversationId = RxString('');

  // Lưu last_id để phân trang conversations
  String? lastConversationId;
  static const int conversationsLimit = 20;

  // Quản lý messages
  final messages = <MessageHistoryModel>[].obs;
  bool hasMoreMessages = false;

  final messageText = ''.obs;

  @override
  void onInit() {
    log('ChatController initialized');
    super.onInit();
    // Load conversations khi khởi tạo
    loadConversations();
  }

  // State quản lý phân trang
  bool hasMoreConversations = false;

  /// Load danh sách conversations
  Future<void> loadConversations() async {
    try {
      if (currentUser.value.isEmpty) return;

      final (list, hasMore) = await _chatRepository.getConversations(
        user: currentUser.value,
        lastId: lastConversationId ?? '',
        limit: conversationsLimit,
      );

      if (list.isNotEmpty) {
        conversations.value = list;
        lastConversationId = list.last.id;
        hasMoreConversations = hasMore;
      }
    } catch (e) {
      showError('Không thể tải conversations: ${e.toString()}');
    }
  }

  /// Load thêm conversations cũ hơn
  Future<void> loadMoreConversations() async {
    if (!hasMoreConversations || lastConversationId == null) return;
    await loadConversations();
  }

  /// Toggle theme mode
  void toggleThemeMode() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  /// Show dialog nhập username
  void showUserDialog(BuildContext context) {
    final TextEditingController userController = TextEditingController(
      text: currentUser.value,
    );

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Nhập tên người dùng'),
            content: TextField(
              controller: userController,
              decoration: InputDecoration(
                hintText: 'Nhập tên của bạn',
                border: OutlineInputBorder(),
              ),
            ),
            actions: [
              TextButton(
                child: Text('Hủy'),
                onPressed: () => Navigator.pop(context),
              ),
              TextButton(
                child: Text('Lưu'),
                onPressed: () {
                  if (userController.text.trim().isNotEmpty) {
                    currentUser.value = userController.text.trim();
                    _storageService.setString(
                      StorageService.keyUser,
                      currentUser.value,
                    );
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
    );
  }

  /// Create new chat
  void newChat() {
    messages.clear();
    selectedConversationId.value = '';
    currentConversationId = '';
  }

  /// Select conversation và load messages
  Future<void> selectConversation(String id) async {
    selectedConversationId.value = id;
    currentConversationId = id;
    messages.clear();

    try {
      final (messageList, hasMore) = await _chatRepository.getMessageHistory(
        user: currentUser.value,
        conversationId: id,
      );

      messages.value = messageList;
      hasMoreMessages = hasMore;
    } catch (e) {
      showError('Không thể tải tin nhắn: ${e.toString()}');
    }
  }

  void logout() {
    Get.offAllNamed('/login');
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    try {
      setLoading(true);
      messages.add(
        MessageHistoryModel(
          id: '',
          conversationId: currentConversationId,
          inputs: {},
          query: text,
          answer: '',
          messageFiles: [],
          feedback: null,
          retrieverResources: [],
          createdAt: DateTime.now(),
        ),
      );

      // Cancel previous subscription if exists
      await _messageSubscription?.cancel();

      // Tạo message bot rỗng để hiển thị animation typing
      messages.add(
        MessageHistoryModel(
          id: '',
          conversationId: currentConversationId,
          inputs: {},
          query: '',
          answer: '',
          messageFiles: [],
          feedback: null,
          retrieverResources: [],
          createdAt: DateTime.now(),
        ),
      );
      final botMessageIndex = messages.length - 1;

      String botResponse = '';

      // Subscribe to message stream
      _messageSubscription = _chatRepository
          .sendMessage(
            query: text,
            conversationId: currentConversationId,
            user: currentUser.value.isEmpty ? 'user' : currentUser.value,
          )
          .listen(
            (message) {
              // Xử lý các loại event khác nhau
              switch (message.event) {
                case 'workflow_started':
                  // Lưu conversation_id khi bắt đầu workflow
                  currentConversationId = message.conversationId ?? '';
                  currentMessageId = message.id;
                  break;

                case 'message':
                  // Cập nhật ngay khi nhận được chunk mới
                  final currentMessage = messages[botMessageIndex];
                  botResponse += message.content;

                  // Clone message cũ và cập nhật answer với chunk mới
                  messages[botMessageIndex] = MessageHistoryModel(
                    id: message.id,
                    conversationId: message.conversationId ?? '',
                    inputs: currentMessage.inputs,
                    query: currentMessage.query,
                    answer: botResponse,
                    messageFiles: currentMessage.messageFiles,
                    feedback: currentMessage.feedback,
                    retrieverResources: currentMessage.retrieverResources,
                    createdAt: currentMessage.createdAt,
                  );
                  break;

                case 'message_end':
                  // Xử lý metadata khi kết thúc response
                  if (message.metadata?.usage != null) {
                    final usage = message.metadata!.usage!;
                    log('Token usage: ${usage['total_tokens']} tokens');
                    log('Cost: ${usage['total_price']} ${usage['currency']}');
                  }
                  break;
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
