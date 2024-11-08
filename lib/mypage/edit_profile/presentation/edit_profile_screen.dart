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

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<EditProfileBloc>()..add(GetMyInfo()),
      child: Builder(builder: (context) {
        return BlocListener<EditProfileBloc, EditProfileState>(
          listenWhen: (prev, next) {
            return prev.myInfo == null && next.myInfo != null;
          },
          listener: (context, state) {
            _controller.text = state.myInfo?.name ?? "No Nickname";
          },
          child: Scaffold(
            backgroundColor: HelloColors.white,
            body: SingleChildScrollView(
              child: MypageBackgroundGradient(
                child: Column(
                  children: [
                    MyPageTitle(onTapConfirm: () {
                      context.read<EditProfileBloc>().add(Submit());
                    }),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "닉네임 변경",
                              style: TextStyle(
                                fontFamily: HelloFonts.pretendard,
                                color: HelloColors.subTextColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Expanded(
                              child: BlocBuilder<EditProfileBloc,
                                  EditProfileState>(
                                builder: (context, state) {
                                  return TextField(
                                    controller: _controller,
                                    onChanged: (value) {
                                      context.read<EditProfileBloc>().add(
                                          NicknameChanged(nickname: value));
                                    },
                                    textAlign: TextAlign.end,
                                    style: const TextStyle(
                                      fontFamily: HelloFonts.pretendard,
                                      fontSize: 12,
                                      color: HelloColors.gray,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    decoration: const InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                    ),
                                  );
                                },
                              ),
                            ),
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
                        ),
                        const SizedBox(height: 14),
                        // GridView.count(
                        //   primary: false,
                        //   padding: EdgeInsets.zero,
                        //   crossAxisCount: 4,
                        //   children: <Widget>[
                        //     Container(
                        //       padding: const EdgeInsets.all(8),
                        //       color: Colors.teal[100],
                        //       child: const Text(
                        //           "He'd have you all unravel at the"),
                        //     ),
                        //     Container(
                        //       padding: const EdgeInsets.all(8),
                        //       color: Colors.teal[200],
                        //       child: const Text('Heed not the rabble'),
                        //     ),
                        //     Container(
                        //       padding: const EdgeInsets.all(8),
                        //       color: Colors.teal[300],
                        //       child: const Text('Sound of screams but the'),
                        //     ),
                        //     Container(
                        //       padding: const EdgeInsets.all(8),
                        //       color: Colors.teal[400],
                        //       child: const Text('Who scream'),
                        //     ),
                        //     Container(
                        //       padding: const EdgeInsets.all(8),
                        //       color: Colors.teal[500],
                        //       child: const Text('Revolution is coming...'),
                        //     ),
                        //     Container(
                        //       padding: const EdgeInsets.all(8),
                        //       color: Colors.teal[600],
                        //       child: const Text('Revolution, they...'),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ))
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class LanguageItem extends StatelessWidget {
  const LanguageItem({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
