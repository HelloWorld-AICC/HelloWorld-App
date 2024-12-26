import 'package:hello_world_mvp/community/common/domain/post.dart';
import 'package:hello_world_mvp/core/value_objects.dart';

class PostDto {
  final String title;
  final String cratedAt;
  final int commentNum;
  final String? imageUrl;

  PostDto(
      {required this.title,
      required this.cratedAt,
      required this.commentNum,
      this.imageUrl});

  static PostDto fromDomain(Post domain) {
    return PostDto(
      title: domain.title.getOrCrash(),
      cratedAt: domain.createdAt.getOrCrash().toString(),
      commentNum: domain.commentNum.getOrCrash(),
      imageUrl: domain.imageUrl?.getOrCrash(),
    );
  }

  Post toDomain() {
    return Post(
      title: StringVO(title),
      createdAt: DateVO(DateTime.parse(cratedAt)),
      commentNum: IntVO(commentNum),
      imageUrl: imageUrl != null ? StringVO(imageUrl) : null,
    );
  }

  factory PostDto.fromJson(Map<String, dynamic> json) {
    return PostDto(
      title: json['title'],
      cratedAt: json['crated_at'],
      commentNum: json['commentNum'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'crated_at': cratedAt,
      'commentNum': commentNum,
      'imageUrl': imageUrl,
    };
  }
}
