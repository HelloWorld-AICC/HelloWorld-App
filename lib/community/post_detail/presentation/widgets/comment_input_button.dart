import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world_mvp/community/post_detail/application/post_detail_bloc.dart';

import '../../../../design_system/hello_colors.dart';
import '../../../../design_system/hello_fonts.dart';

class CommentInputButton extends StatelessWidget {
  final int postId;
  final int categoryId;
  final TextEditingController _controller = TextEditingController();

  CommentInputButton({
    super.key,
    required this.postId,
    required this.categoryId,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Container(
        height: MediaQuery.sizeOf(context).height * 0.05,
        decoration: BoxDecoration(
          color: HelloColors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: HelloColors.mainBlue,
            width: 1,
          ),
          boxShadow: const [
            BoxShadow(
              color: HelloColors.subTextColor,
              blurRadius: 4.0,
              spreadRadius: 0.0,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.7,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _controller, // Attach the controller
                    decoration: const InputDecoration(
                      hintText: "댓글을 입력해주세요",
                      hintStyle: TextStyle(
                        fontFamily: HelloFonts.sbAggroOTF,
                        color: HelloColors.subTextColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                final comment = _controller.text.trim(); // Get the text input
                if (comment.isNotEmpty) {
                  context.read<PostDetailBloc>().add(
                        PostDetailCommentAdded(
                          categoryId: categoryId,
                          postId: postId,
                          comment: comment, // Pass the comment here
                        ),
                      );
                  _controller.clear(); // Clear the text field after submission
                } else {
                  // Optional: Show a message if the input is empty
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("댓글을 입력해주세요.")),
                  );
                }
              },
              icon: Image.asset("assets/icons/upload_button.png"),
            ),
          ],
        ),
      ),
    );
  }
}
