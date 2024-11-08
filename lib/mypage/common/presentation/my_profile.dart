import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hello_world_mvp/design_system/hello_colors.dart';
import 'package:hello_world_mvp/design_system/hello_fonts.dart';
import 'package:image_picker/image_picker.dart';

class MyProfile extends StatelessWidget {
  final String? userImg;
  final String? name;
  final Function? onTapEditImage;
  final XFile? selectedImage;
  const MyProfile(
      {super.key,
      required this.userImg,
      required this.name,
      required this.selectedImage,
      this.onTapEditImage});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 11.0),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0xFF10498E), // #10498E
                          blurRadius: 4.0,
                          offset: Offset(0, 0), // 그림자의 x, y 오프셋
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 50.0,
                      backgroundImage: selectedImage != null
                          ? Image.file(File(selectedImage!.path)).image
                          : userImg != null
                              ? NetworkImage(userImg ?? "")
                              : null,
                      backgroundColor: Colors.grey,
                    ),
                  ),
                ),
                if (onTapEditImage != null)
                  InkWell(
                    onTap: () => onTapEditImage!(),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                100), // border-radius: 100px
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                const Color.fromRGBO(0, 0, 0, 0.70)
                                    .withOpacity(0.0), // rgba(0, 0, 0, 0.70)
                                const Color.fromRGBO(
                                    0, 0, 0, 0.70), // rgba(0, 0, 0, 0.70)
                              ],
                            ),
                          ),
                          child: Center(
                              child: SvgPicture.asset(
                            "assets/images/mypage/camera.svg",
                            colorFilter: const ColorFilter.mode(
                              HelloColors.mainBlue,
                              BlendMode.srcIn, // 색상을 덮어쓸 때 사용하는 BlendMode
                            ),
                          ))),
                    ),
                  )
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: 102,
            height: 22,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: HelloColors.white,
              boxShadow: [
                BoxShadow(
                  color: HelloColors.mainColor1.withOpacity(0.75),
                  blurRadius: 4.0,
                  spreadRadius: 0.0,
                  offset: const Offset(0, 0), // x, y 축의 그림자 위치
                ),
              ],
            ),
            child: Center(
              child: Text(
                name ?? "No Profile",
                style: const TextStyle(
                  fontFamily: HelloFonts.pretendard,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
