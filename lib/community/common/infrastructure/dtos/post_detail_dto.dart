// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hello_world_mvp/community/common/infrastructure/dtos/comment_dto.dart';
import 'package:hello_world_mvp/core/value_objects.dart';

class PostDetailDto {
  final String title;
  final String content;
  final String createdAt;
  final List<String> fileList;
  final List<CommentDto> commentDtoList;

  PostDetailDto(
      {required this.title,
      required this.content,
      required this.createdAt,
      required this.fileList,
      required this.commentDtoList});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'title': title,
      'content': content,
      'createdAt': createdAt,
      'fileList': fileList,
      'commentDTOList': commentDtoList.map((x) => x.toJson()).toList(),
    };
  }

  factory PostDetailDto.fromJson(Map<String, dynamic> map) {
    return PostDetailDto(
      title: map['title'] as String,
      content: map['content'] as String,
      createdAt: map['createdAt'] as String,
      fileList: List<String>.from((map['fileList'] as List<String>)),
      commentDtoList: List<CommentDto>.from(
        (map['commentDTOList'] as List<dynamic>).map<CommentDto>(
          (x) => CommentDto.fromJson(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}
