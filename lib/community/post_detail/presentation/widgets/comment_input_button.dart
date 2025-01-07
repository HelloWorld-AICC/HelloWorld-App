import 'package:flutter/material.dart';

import '../../../../design_system/hello_colors.dart';
import '../../../../design_system/hello_fonts.dart';

class CommentInputButton extends StatelessWidget {
  const CommentInputButton({
    super.key,
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
                onPressed: () {},
                icon: Image.asset("assets/icons/upload_button.png"),
              ),
            ],
          )),
    );
  }
}
