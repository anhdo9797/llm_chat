/// Model response từ API conversations
class ConversationsResponse {
  final int limit;
  final bool hasMore;
  final List<ConversationModel> data;

  ConversationsResponse({
    required this.limit,
    required this.hasMore,
    required this.data,
  });

  factory ConversationsResponse.fromJson(Map<String, dynamic> json) {
    return ConversationsResponse(
      limit: json['limit'] as int,
      hasMore: json['has_more'] as bool,
      data:
          (json['data'] as List)
              .map(
                (item) =>
                    ConversationModel.fromJson(item as Map<String, dynamic>),
              )
              .toList(),
    );
  }
}

/// Model lưu thông tin conversation
class ConversationModel {
  final String id;
  final String name;
  final Map<String, dynamic> inputs;
  final String status;
  final String introduction;
  final DateTime createdAt;
  final DateTime updatedAt;

  ConversationModel({
    required this.id,
    required this.name,
    required this.inputs,
    required this.status,
    required this.introduction,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: json['id'] as String,
      name: json['name'] as String,
      inputs: json['inputs'] as Map<String, dynamic>,
      status: json['status'] as String,
      introduction: json['introduction'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        (json['created_at'] as int) * 1000, // Convert to milliseconds
      ),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(
        (json['updated_at'] as int) * 1000, // Convert to milliseconds
      ),
    );
  }
}
