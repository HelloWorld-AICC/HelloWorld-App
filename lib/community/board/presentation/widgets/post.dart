import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_world_mvp/design_system/hello_colors.dart';
import 'package:hello_world_mvp/design_system/hello_fonts.dart';

class Post extends StatelessWidget {
  const Post({
    super.key,
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
              const _Title(),
              const SizedBox(height: 4),
              Row(
                children: [
                  const _Date(),
                  const SizedBox(width: 12),
                  SvgPicture.asset("assets/images/community/comment.svg"),
                  const SizedBox(width: 2),
                  const _CommentCount()
                ],
              )
            ],
          ),
          Container(
            width: 21,
            height: 21,
            decoration: BoxDecoration(
                color: Colors.red, borderRadius: BorderRadius.circular(4.0)),
          )
        ],
      )),
    );
  }
}

class _CommentCount extends StatelessWidget {
  const _CommentCount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text("39",
        style: TextStyle(
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
  const _Date({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text("2024.03.08",
        style: TextStyle(
          fontFamily: HelloFonts.inter,
          fontSize: 8,
          fontWeight: FontWeight.w400,
          height: 10 / 8,
          letterSpacing: 0.08,
        ));
  }
}

class _Title extends StatelessWidget {
  const _Title({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text("1경기 전력 어떻게 봐 ?",
        style: TextStyle(
          fontFamily: HelloFonts.inter,
          fontSize: 12,
          fontWeight: FontWeight.w900,
          height: 12 / 12,
          letterSpacing: 0.12,
        ));
  }
}
