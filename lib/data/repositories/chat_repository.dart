import '../models/message_model.dart';
import '../providers/api_provider.dart';

/// Repository for chat functionality
class ChatRepository {
  final ApiProvider _apiProvider;

  ChatRepository({required ApiProvider apiProvider})
    : _apiProvider = apiProvider;

  /// Get paginated messages
  ///
  /// [page]: Page number starting from 1
  /// [limit]: Number of items per page
  /// Returns a list of messages ordered by timestamp
  Future<List<MessageModel>> getMessages({int page = 1, int limit = 20}) async {
    try {
      final messages = await _apiProvider.getMessages(page: page, limit: limit);

      // Sort messages by timestamp
      messages.sort((a, b) => b.timestamp.compareTo(a.timestamp));

      return messages;
    } catch (e) {
      rethrow;
    }
  }

  /// Send a new message và nhận response dạng stream
  ///
  /// [query]: Nội dung tin nhắn
  /// [conversationId]: ID của cuộc hội thoại (optional)
  /// [user]: Người gửi tin nhắn
  /// Returns stream of response chunks
  Stream<String> sendMessage({
    required String query,
    String conversationId = '',
    String user = 'user',
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
