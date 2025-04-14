import 'package:get/get.dart';
import '../../services/api_service.dart';
import '../models/message_model.dart';

/// Provider for API calls
class ApiProvider {
  // Get API service instance
  final ApiService _api = Get.find<ApiService>();

  /// Get chat messages
  Future<List<MessageModel>> getMessages({
    required int page,
    required int limit,
  }) async {
    try {
      final response = await _api.get(
        '/messages',
        queryParameters: {'page': page, 'limit': limit},
      );

      return (response.data as List)
          .map((json) => MessageModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  /// Send a message và nhận response dạng stream
  Stream<String> sendMessage({
    required String query,
    String conversationId = '',
    String user = 'user',
  }) {
    try {
      return _api.postStream(
        '/v1/chat-messages',
        data: {
          'inputs': {},
          'query': query,
          'response_mode': 'streaming',
          'conversation_id': conversationId,
          'user': user,
        },
      );
    } catch (e) {
      rethrow;
    }
  }
}
