import 'dart:convert';

/// File attachment model for messages
class FileAttachment {
  final String type;
  final String transferMethod;
  final String url;

  FileAttachment({
    required this.type,
    required this.transferMethod,
    required this.url,
  });

  /// Create model from JSON
  factory FileAttachment.fromJson(Map<String, dynamic> json) => FileAttachment(
    type: json['type'] as String,
    transferMethod: json['transfer_method'] as String,
    url: json['url'] as String,
  );

  /// Convert model to JSON
  Map<String, dynamic> toJson() => {
    'type': type,
    'transfer_method': transferMethod,
    'url': url,
  };
}

/// Message metadata model for tracking usage and resources
class MessageMetadata {
  final Map<String, dynamic>? usage;
  final List<Map<String, dynamic>>? retrieverResources;

  MessageMetadata({this.usage, this.retrieverResources});

  /// Create model from JSON
  factory MessageMetadata.fromJson(Map<String, dynamic> json) =>
      MessageMetadata(
        usage: json['usage'] as Map<String, dynamic>?,
        retrieverResources:
            (json['retriever_resources'] as List?)
                ?.map((e) => e as Map<String, dynamic>)
                .toList(),
      );

  /// Convert model to JSON
  Map<String, dynamic> toJson() => {
    'usage': usage,
    'retriever_resources': retrieverResources,
  };
}

/// Message model for chat functionality
class MessageModel {
  final String id;
  final String content;
  final String sender;
  final DateTime timestamp;
  final bool isRead;

  // New fields
  final String? conversationId;
  final Map<String, dynamic>? inputs;
  final List<FileAttachment>? files;
  final MessageMetadata? metadata;
  final String? event;

  MessageModel({
    required this.id,
    required this.content,
    required this.sender,
    required this.timestamp,
    this.isRead = false,
    this.conversationId,
    this.inputs,
    this.files,
    this.metadata,
    this.event,
  });

  /// Create model from JSON
  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
    id: json['id'] as String,
    content: json['content'] as String,
    sender: json['sender'] as String,
    timestamp: DateTime.parse(json['timestamp'] as String),
    isRead: json['is_read'] as bool? ?? false,
    conversationId: json['conversation_id'] as String?,
    inputs: json['inputs'] as Map<String, dynamic>?,
    files:
        (json['files'] as List?)
            ?.map((e) => FileAttachment.fromJson(e as Map<String, dynamic>))
            .toList(),
    metadata:
        json['metadata'] == null
            ? null
            : MessageMetadata.fromJson(
              json['metadata'] as Map<String, dynamic>,
            ),
    event: json['event'] as String?,
  );

  /// Convert model to JSON
  Map<String, dynamic> toJson() => {
    'id': id,
    'content': content,
    'sender': sender,
    'timestamp': timestamp.toIso8601String(),
    'is_read': isRead,
    'conversation_id': conversationId,
    'inputs': inputs,
    'files': files?.map((e) => e.toJson()).toList(),
    'metadata': metadata?.toJson(),
    'event': event,
  };

  /// Create model from JSON string
  factory MessageModel.fromString(String str) =>
      MessageModel.fromJson(json.decode(str) as Map<String, dynamic>);

  /// Convert model to JSON string
  String toString() => json.encode(toJson());

  /// Create a copy of this model with modified fields
  MessageModel copyWith({
    String? id,
    String? content,
    String? sender,
    DateTime? timestamp,
    bool? isRead,
    String? conversationId,
    Map<String, dynamic>? inputs,
    List<FileAttachment>? files,
    MessageMetadata? metadata,
    String? event,
  }) => MessageModel(
    id: id ?? this.id,
    content: content ?? this.content,
    sender: sender ?? this.sender,
    timestamp: timestamp ?? this.timestamp,
    isRead: isRead ?? this.isRead,
    conversationId: conversationId ?? this.conversationId,
    inputs: inputs ?? this.inputs,
    files: files ?? this.files,
    metadata: metadata ?? this.metadata,
    event: event ?? this.event,
  );
}
