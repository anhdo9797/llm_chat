/// Model response từ API messages
class MessageHistoryResponse {
  final int limit;
  final bool hasMore;
  final List<MessageHistoryModel> data;

  MessageHistoryResponse({
    required this.limit,
    required this.hasMore,
    required this.data,
  });

  factory MessageHistoryResponse.fromJson(Map<String, dynamic> json) {
    return MessageHistoryResponse(
      limit: json['limit'] as int,
      hasMore: json['has_more'] as bool,
      data:
          (json['data'] as List)
              .map(
                (item) =>
                    MessageHistoryModel.fromJson(item as Map<String, dynamic>),
              )
              .toList(),
    );
  }
}

/// Model lưu thông tin message history
class MessageHistoryModel {
  final String id;
  final String conversationId;
  final Map<String, dynamic> inputs;
  final String query;
  final String answer;
  final List<dynamic> messageFiles;
  final dynamic feedback;
  final List<RetrieverResource> retrieverResources;
  final DateTime createdAt;

  MessageHistoryModel({
    required this.id,
    required this.conversationId,
    required this.inputs,
    required this.query,
    required this.answer,
    required this.messageFiles,
    required this.feedback,
    required this.retrieverResources,
    required this.createdAt,
  });

  factory MessageHistoryModel.fromJson(Map<String, dynamic> json) {
    return MessageHistoryModel(
      id: json['id'] as String,
      conversationId: json['conversation_id'] as String,
      inputs: json['inputs'] as Map<String, dynamic>,
      query: json['query'] as String,
      answer: json['answer'] as String,
      messageFiles: json['message_files'] as List<dynamic>,
      feedback: json['feedback'],
      retrieverResources:
          (json['retriever_resources'] as List)
              .map(
                (item) =>
                    RetrieverResource.fromJson(item as Map<String, dynamic>),
              )
              .toList(),
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        (json['created_at'] as int) * 1000, // Convert to milliseconds
      ),
    );
  }
}

/// Model lưu thông tin retriever resource
class RetrieverResource {
  final int position;
  final String datasetId;
  final String datasetName;
  final String documentId;
  final String documentName;
  final String segmentId;
  final double score;
  final String content;

  RetrieverResource({
    required this.position,
    required this.datasetId,
    required this.datasetName,
    required this.documentId,
    required this.documentName,
    required this.segmentId,
    required this.score,
    required this.content,
  });

  factory RetrieverResource.fromJson(Map<String, dynamic> json) {
    return RetrieverResource(
      position: json['position'] as int,
      datasetId: json['dataset_id'] as String,
      datasetName: json['dataset_name'] as String,
      documentId: json['document_id'] as String,
      documentName: json['document_name'] as String,
      segmentId: json['segment_id'] as String,
      score: json['score'] as double,
      content: json['content'] as String,
    );
  }
}
