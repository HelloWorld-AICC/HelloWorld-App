import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CommentDto {
  final int anonymousName;
  final String createdAt;
  final String content;

  CommentDto(
      {required this.anonymousName,
      required this.createdAt,
      required this.content});

  CommentDto copyWith({
    int? anonymousName,
    String? createdAt,
    String? content,
  }) {
    return CommentDto(
      anonymousName: anonymousName ?? this.anonymousName,
      createdAt: createdAt ?? this.createdAt,
      content: content ?? this.content,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'anonymousName': anonymousName,
      'createdAt': createdAt,
      'content': content,
    };
  }

  factory CommentDto.fromJson(Map<String, dynamic> map) {
    return CommentDto(
      anonymousName: (map['anonymousName'] as num).toInt(),
      createdAt: map['createdAt'] as String,
      content: map['content'] as String,
    );
  }
}
