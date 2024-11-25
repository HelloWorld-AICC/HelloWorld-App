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
import 'package:hello_world_mvp/mypage/edit_profile/presentation/language_flag.dart';

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
        return MultiBlocListener(
          listeners: [
            BlocListener<EditProfileBloc, EditProfileState>(
              listenWhen: (prev, next) {
                return prev.myInfo == null && next.myInfo != null;
              },
              listener: (context, state) {
                _controller.text = state.myInfo?.name ?? "No Nickname";
              },
            ),
            BlocListener<EditProfileBloc, EditProfileState>(
              listenWhen: (prev, next) {
                return prev.isSuccess == false && next.isSuccess == true;
              },
              listener: (context, state) {
                Navigator.of(context).pop();
              },
            ),
          ],
          child: Scaffold(
            backgroundColor: HelloColors.white,
            body: SingleChildScrollView(
              child: MypageBackgroundGradient(
                child: Column(
                  children: [
                    BlocBuilder<EditProfileBloc, EditProfileState>(
                      builder: (context, state) {
                        return MyPageTitle(
                            isConfirmActivated:
                                state.selectedProfileImage != null ||
                                    state.newNickname != null,
                            onTapConfirm: () {
                              context.read<EditProfileBloc>().add(Submit());
                            });
                      },
                    ),
                    const SizedBox(height: 30),
                    BlocBuilder<EditProfileBloc, EditProfileState>(
                      builder: (context, state) {
                        return MyProfile(
                          selectedImage: state.selectedProfileImage,
                          userImg: state.myInfo?.userImg,
                          name: state.myInfo?.name,
                          onTapEditImage: () {
                            context.read<EditProfileBloc>().add(SelectImage());
                          },
                        );
                      },
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
                        Container(
                          height: 200,
                          child: GridView.count(
                            primary: false,
                            padding: EdgeInsets.zero,
                            crossAxisCount: 4,
                            children: const <Widget>[
                              LanguageFlag(
                                lanagaue: Language.korean,
                              ),
                              LanguageFlag(
                                lanagaue: Language.chinese,
                              ),
                              LanguageFlag(
                                lanagaue: Language.vietnamese,
                              ),
                              LanguageFlag(
                                lanagaue: Language.japanese,
                              ),
                              LanguageFlag(
                                lanagaue: Language.english,
                              ),
                            ],
                          ),
                        ),
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
