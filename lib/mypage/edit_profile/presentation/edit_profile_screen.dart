import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world_mvp/design_system/hello_colors.dart';
import 'package:hello_world_mvp/design_system/hello_fonts.dart';
import 'package:hello_world_mvp/injection.dart';
import 'package:hello_world_mvp/mypage/common/presentation/my_profile.dart';
import 'package:hello_world_mvp/mypage/common/presentation/mypage_background_gradient.dart';
import 'package:hello_world_mvp/mypage/common/presentation/mypage_box.dart';
import 'package:hello_world_mvp/mypage/common/presentation/mypage_title.dart';
import 'package:hello_world_mvp/mypage/edit_profile/application/edit_profile_bloc.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<EditProfileBloc>()..add(GetMyInfo()),
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: HelloColors.white,
          body: SingleChildScrollView(
            child: MypageBackgroundGradient(
              child: Column(
                children: [
                  MyPageTitle(onTapConfirm: () {}),
                  const SizedBox(height: 30),
                  MyProfile(
                    userImg: null,
                    name: null,
                    onTapEditImage: () {},
                  ),
                  const SizedBox(height: 36),
                  MypageBox(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("프로필 변경",
                          style: TextStyle(
                            fontFamily: HelloFonts.pretendard,
                            fontSize: 12,
                            color: HelloColors.mainColor1,
                            fontWeight: FontWeight.w500,
                          )),
                      const SizedBox(height: 16),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "닉네임 변경",
                            style: TextStyle(
                              fontFamily: HelloFonts.pretendard,
                              color: HelloColors.subTextColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text("Song Taeseop",
                              style: TextStyle(
                                fontFamily: HelloFonts.pretendard,
                                fontSize: 12,
                                color: HelloColors.gray,
                                fontWeight: FontWeight.w500,
                              ))
                        ],
                      ),
                      const SizedBox(height: 20),
                      Container(height: 1, color: const Color(0xFFE6E6E6)),
                      const SizedBox(height: 20),
                      const Text(
                        "언어 변경",
                        style: TextStyle(
                          fontFamily: HelloFonts.pretendard,
                          color: HelloColors.subTextColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ))
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
