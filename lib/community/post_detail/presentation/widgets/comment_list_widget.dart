import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../design_system/hello_fonts.dart';
import '../../../../mypage/common/presentation/mypage_box.dart';
import '../../application/post_detail_bloc.dart';

class CommentListWidget extends StatelessWidget {
  const CommentListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MypageBox(
        child: ListView.separated(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: context.read<PostDetailBloc>().state.comments.length,
      itemBuilder: (context, index) {
        var anonymousName =
            context.read<PostDetailBloc>().state.comments[index].anonymousName;
        var createdAtAsDatetime = context
            .read<PostDetailBloc>()
            .state
            .comments[index]
            .createdAt
            .value
            .getOrElse(() => DateTime.now());

        var createdAt =
            DateFormat('yyyy.MM.dd HH:mm').format(createdAtAsDatetime);
        var content = context
            .read<PostDetailBloc>()
            .state
            .comments[index]
            .content
            .value
            .getOrElse(() => "");

        print(
            "anonymousName: $anonymousName, createdAt: $createdAt, content: $content");

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  anonymousName.toString(),
                  style: const TextStyle(
                    color: Color(0xff6D9CD5),
                    fontFamily: HelloFonts.inter,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.14,
                  ),
                ),
                Text(
                  createdAt.toString(),
                  style: const TextStyle(
                    color: Color(0xff6D9CD5),
                    fontFamily: HelloFonts.inter,
                    fontSize: 8,
                    fontWeight: FontWeight.normal,
                    letterSpacing: 0.14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 3),
            Text(
              content.toString(),
              style: const TextStyle(
                color: Color(0xff6D9CD5),
                fontFamily: HelloFonts.inter,
                fontSize: 12,
                fontWeight: FontWeight.normal,
                letterSpacing: 0.14,
              ),
            ),
          ],
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 16);
      },
    ));
  }
}
