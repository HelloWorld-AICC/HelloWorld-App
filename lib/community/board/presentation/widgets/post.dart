import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_world_mvp/community/common/domain/post.dart';
import 'package:hello_world_mvp/core/value_objects.dart';
import 'package:hello_world_mvp/design_system/hello_colors.dart';
import 'package:hello_world_mvp/design_system/hello_fonts.dart';

class PostItem extends StatelessWidget {
  final Post post;
  const PostItem({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push('/community/post-detail');
      },
      child: Container(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Title(text: post.title.getOrCrash()),
              const SizedBox(height: 4),
              Row(
                children: [
                  _Date(
                    dateTime: post.createdAt,
                  ),
                  const SizedBox(width: 12),
                  SvgPicture.asset("assets/images/community/comment.svg"),
                  const SizedBox(width: 2),
                  _CommentCount(count: post.commentNum.getOrCrash())
                ],
              )
            ],
          ),
          if (post.imageUrl != null)
            Container(
                width: 21,
                height: 21,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Image.network(post.imageUrl!.getOrCrash()))
        ],
      )),
    );
  }
}

class _CommentCount extends StatelessWidget {
  final int count;
  const _CommentCount({
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Text(count.toString(),
        style: const TextStyle(
          color: HelloColors.gray,
          fontFamily: HelloFonts.inter,
          fontSize: 6,
          fontWeight: FontWeight.w400,
          height: 4 / 6,
          letterSpacing: 0.06,
        ));
  }
}

class _Date extends StatelessWidget {
  final DateVO dateTime;
  const _Date({
    required this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    final formattedDate =
        DateFormat('yyyy-MM-dd').format(dateTime.getOrCrash());
    return Text(formattedDate,
        style: const TextStyle(
          fontFamily: HelloFonts.inter,
          fontSize: 8,
          fontWeight: FontWeight.w400,
          height: 10 / 8,
          letterSpacing: 0.08,
        ));
  }
}

class _Title extends StatelessWidget {
  final String text;
  const _Title({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: const TextStyle(
          fontFamily: HelloFonts.inter,
          fontSize: 12,
          fontWeight: FontWeight.w900,
          height: 12 / 12,
          letterSpacing: 0.12,
        ));
  }
}
