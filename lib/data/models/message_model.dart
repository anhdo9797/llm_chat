import 'dart:convert';

/// Message model for chat functionality
class MessageModel {
  final String id;
  final String content;
  final String sender;
  final DateTime timestamp;
  final bool isRead;

  MessageModel({
    required this.id,
    required this.content,
    required this.sender,
    required this.timestamp,
    this.isRead = false,
  });

  /// Create model from JSON
  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
    id: json['id'] as String,
    content: json['content'] as String,
    sender: json['sender'] as String,
    timestamp: DateTime.parse(json['timestamp'] as String),
    isRead: json['is_read'] as bool? ?? false,
  );

  /// Convert model to JSON
  Map<String, dynamic> toJson() => {
    'id': id,
    'content': content,
    'sender': sender,
    'timestamp': timestamp.toIso8601String(),
    'is_read': isRead,
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
  }) => MessageModel(
    id: id ?? this.id,
    content: content ?? this.content,
    sender: sender ?? this.sender,
    timestamp: timestamp ?? this.timestamp,
    isRead: isRead ?? this.isRead,
  );
}
