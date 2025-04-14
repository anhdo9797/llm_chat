import '../models/message_model.dart';
import '../models/conversation_model.dart';
import '../models/message_history_model.dart';
import '../providers/api_provider.dart';

/// Repository for chat functionality
class ChatRepository {
  final ApiProvider _apiProvider;

  ChatRepository({required ApiProvider apiProvider})
    : _apiProvider = apiProvider;

  /// Get conversations list
  ///
  /// [user]: ID người dùng
  /// [lastId]: ID của conversation cuối cùng để phân trang
  /// [limit]: Số lượng conversations trả về
  /// Returns tuple (conversations, hasMore)
  Future<(List<ConversationModel>, bool)> getConversations({
    required String user,
    String lastId = '',
    int limit = 20,
  }) async {
    try {
      final response = await _apiProvider.getConversations(
        user: user,
        lastId: lastId,
        limit: limit,
      );
      return (response.data, response.hasMore);
    } catch (e) {
      rethrow;
    }
  }

  /// Get message history của conversation
  Future<(List<MessageHistoryModel>, bool)> getMessageHistory({
    required String user,
    required String conversationId,
  }) async {
    try {
      final response = await _apiProvider.getMessageHistory(
        user: user,
        conversationId: conversationId,
      );

      // Sort messages by timestamp
      final messages = response.data;
      messages.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      return (messages, response.hasMore);
    } catch (e) {
      rethrow;
    }
  }

  /// Gửi tin nhắn và nhận response dạng stream
  ///
  /// [query]: Nội dung tin nhắn
  /// [conversationId]: ID của cuộc hội thoại nếu là tin nhắn trong cuộc hội thoại cũ
  /// [user]: ID người dùng gửi tin nhắn
  /// [files]: Danh sách file đính kèm (hình ảnh, video, etc)
  /// Returns stream of message events:
  /// - workflow_started: Bắt đầu xử lý
  /// - node_started/finished: Trạng thái của từng bước xử lý
  /// - message: Chunk của câu trả lời
  /// - message_end: Kết thúc response kèm metadata
  Stream<MessageModel> sendMessage({
    required String query,
    String conversationId = '',
    String user = 'user',
    List<FileAttachment>? files,
  }) {
    try {
      // Validate content
      if (query.trim().isEmpty) {
        throw ArgumentError('Message content cannot be empty');
      }

      return _apiProvider.sendMessage(
        query: query,
        conversationId: conversationId,
        user: user,
        files: files,
      );
    } catch (e) {
      rethrow;
    }
  }

  /// Mark message as read
  ///
  /// [messageId]: ID of the message to mark as read
  /// Returns the updated message
  Future<MessageModel> markMessageAsRead(String messageId) async {
    try {
      // TODO: Implement mark as read API call
      throw UnimplementedError('Mark as read not implemented');
    } catch (e) {
      rethrow;
    }
  }

  /// Delete a message
  ///
  /// [messageId]: ID of the message to delete
  Future<void> deleteMessage(String messageId) async {
    try {
      // TODO: Implement delete message API call
      throw UnimplementedError('Delete message not implemented');
    } catch (e) {
      rethrow;
    }
  }
}
