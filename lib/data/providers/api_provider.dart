import 'dart:convert';
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

  /// Gửi tin nhắn và nhận response dạng stream
  /// Flow:
  /// 1. Gửi request với query + files đính kèm
  /// 2. Server trả về stream các events:
  ///   - workflow_started: Bắt đầu xử lý
  ///   - node_started: Bắt đầu 1 node trong workflow
  ///   - node_finished: Kết thúc xử lý node
  ///   - workflow_finished: Hoàn thành workflow
  ///   - message: Từng chunk của câu trả lời
  ///   - message_end: Kết thúc response
  Stream<MessageModel> sendMessage({
    required String query,
    String conversationId = '',
    String user = 'user',
    List<FileAttachment>? files,
  }) async* {
    try {
      final stream = _api.postStream(
        '/v1/chat-messages',
        data: {
          'inputs': {},
          'query': query,
          'response_mode': 'streaming',
          'conversation_id': conversationId,
          'user': user,
          if (files != null)
            'files': files.map((file) => file.toJson()).toList(),
        },
      );

      await for (final data in stream) {
        try {
          final Map<String, dynamic> json = jsonDecode(data);

          // Parse event data thành MessageModel
          final MessageModel message = MessageModel(
            id: json['message_id'] ?? json['id'] ?? '',
            content: json['answer'] ?? '',
            sender: 'bot',
            timestamp: DateTime.fromMillisecondsSinceEpoch(
              (json['created_at'] as int?) ??
                  DateTime.now().millisecondsSinceEpoch,
            ),
            conversationId: json['conversation_id'],
            event: json['event'],
            metadata:
                json['metadata'] == null
                    ? null
                    : MessageMetadata.fromJson(
                      json['metadata'] as Map<String, dynamic>,
                    ),
          );

          yield message;
        } catch (e) {
          print('Error parsing message: $e');
          continue;
        }
      }
    } catch (e) {
      rethrow;
    }
  }
}
