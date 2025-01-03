// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:hello_world_mvp/community/common/domain/post.dart';
import 'package:hello_world_mvp/core/value_objects.dart';

class PostDto {
  final int postId;
  final String title;
  final String createdAt;
  final int commentNum;
  final String? imageUrl;

  PostDto(
      {required this.postId,
      required this.title,
      required this.createdAt,
      required this.commentNum,
      this.imageUrl});

  static PostDto fromDomain(Post domain) {
    return PostDto(
      postId: domain.postId.getOrCrash(),
      title: domain.title.getOrCrash(),
      createdAt: domain.createdAt.getOrCrash().toString(),
      commentNum: domain.commentNum.getOrCrash(),
      imageUrl: domain.imageUrl?.getOrCrash(),
    );
  }

  Post toDomain() {
    return Post(
      postId: IdVO(postId),
      title: StringVO(title),
      createdAt: DateVO(DateTime.parse(createdAt)),
      commentNum: IntVO(commentNum),
      imageUrl: imageUrl != null ? StringVO(imageUrl) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'post_id': postId,
      'title': title,
      'created_at': createdAt,
      'commentNum': commentNum,
      'imageUrl': imageUrl,
    };
  }

  factory PostDto.fromJson(Map<String, dynamic> map) {
    // 서버에서 imageUrl을 문자열로 반환하는 케이스가 있어 방어합니다.
    if (map['imageUrl'] == "null") {
      map['imageUrl'] = null;
    }

    return PostDto(
      postId: (map['post_id'] as num).toInt(),
      title: map['title'] as String,
      createdAt: map['created_at'] as String,
      commentNum: map['commentNum'] as int,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
    );
  }
}
