// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hello_world_mvp/community/common/infrastructure/dtos/comment_dto.dart';
import 'package:hello_world_mvp/core/value_objects.dart';

import '../../domain/comment.dart';
import '../../domain/post_detail.dart';

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

  // factory PostDetailDto.fromJson(Map<String, dynamic> map) {
  //   print('PostDetailDto.fromJson: $map');
  //   return PostDetailDto(
  //     title: map['title'] as String? ?? '',
  //     content: map['content'] as String? ?? '',
  //     createdAt: map['createdAt'] as String? ?? '',
  //     fileList: List<String>.from(
  //       (map['fileList'] as List<dynamic>? ?? [])
  //           .where((file) => file != null)
  //           .map((file) => file as String),
  //     ),
  //     commentDtoList: List<CommentDto>.from(
  //       (map['commentDTOList'] as List<dynamic>? ?? []).map<CommentDto>(
  //         (x) => CommentDto.fromJson(x as Map<String, dynamic>),
  //       ),
  //     ),
  //   );
  // }

  factory PostDetailDto.fromJson(Map<String, dynamic> map) {
    var fileList = map['fileList'] as List<dynamic>? ?? [];
    List<String> processedFileList = [];
    for (var file in fileList) {
      if (file != null) {
        processedFileList.add(file as String);
      }
    }

    var commentDtoList = map['commentDTOList'] as List<dynamic>? ?? [];
    List<CommentDto> processedCommentList = [];
    for (var comment in commentDtoList) {
      int anonymousName = comment['anonymousName'] as int;
      String createdAt = comment['created_at'] as String? ?? '';
      String content = comment['content'] as String? ?? '';

      // Create CommentDto using the safely extracted data
      processedCommentList.add(CommentDto(
        anonymousName: anonymousName,
        createdAt: createdAt,
        content: content,
      ));
    }

    return PostDetailDto(
      title: map['title'] as String? ?? '',
      content: map['content'] as String? ?? '',
      createdAt: map['created_at'] as String? ?? '',
      fileList: processedFileList,
      commentDtoList: processedCommentList,
    );
  }

  PostDetail toDomain() {
    return PostDetail(
      title: StringVO(title),
      content: StringVO(content),
      createAt: StringVO(createdAt),
      fileList: ListVO<StringVO>(
        fileList.map((e) => StringVO(e)).toList(),
      ),
      commentList: ListVO<Comment>(
        commentDtoList.map((e) => e.toDomain()).toList(),
      ),
    );
  }

  @override
  String toString() {
    return 'PostDetailDto(title: $title, content: $content, createdAt: $createdAt, fileList: $fileList, commentDtoList: $commentDtoList)';
  }
}
