import 'dart:convert';

import '../../../../core/value_objects.dart';
import '../../domain/comment.dart';

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

  Comment toDomain() {
    return Comment(
      anonymousName: anonymousName,
      createdAt: DateVO(parseDate(createdAt)),
      content: StringVO(content),
    );
  }

  DateTime parseDate(String dateString) {
    DateTime parsedDate = DateTime.parse(dateString);
    return parsedDate;
  }

// DateTime parseDate(String date) {
//   final parts = date.split('.');
//   if (parts.length != 3) {
//     throw FormatException('Invalid date format. Expected "yyyy.MM.dd".');
//   }
//
//   final year = int.parse(parts[0]);
//   final month = int.parse(parts[1]);
//   final day = int.parse(parts[2]);
//
//   return DateTime(year, month, day);
// }
}
