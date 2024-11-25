import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hello_world_mvp/design_system/hello_colors.dart';
import 'package:hello_world_mvp/design_system/hello_fonts.dart';
import 'package:hello_world_mvp/injection.dart';
import 'package:hello_world_mvp/main.dart';
import 'package:hello_world_mvp/mypage/account/application/signout_bloc.dart';

Future<void> showSignOutDailog(BuildContext context) async {
  return await showDialog(
      context: context,
      builder: (context) {
        return BlocProvider(
          create: (context) => getIt<SignOutBloc>(),
          child: Builder(builder: (context) {
            return BlocListener<SignOutBloc, SignOutState>(
              listenWhen: (prev, next) {
                return (prev.isSignedOut != next.isSignedOut) &&
                    next.isSignedOut == true;
              },
              listener: (context, state) {
                while (context.canPop()) {
                  context.pop();
                }
                context.push("/login");
              },
              child: Container(
                color: Colors.black.withOpacity(0.8),
                child: Dialog(
                  backgroundColor: Colors.black.withOpacity(0.8),
                  shadowColor: Colors.black.withOpacity(0.8),
                  surfaceTintColor: Colors.black.withOpacity(0.8),
                  child: Container(
                      decoration: BoxDecoration(
                        color: HelloColors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.only(
                          top: 31, left: 24, right: 26, bottom: 27),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                              "assets/images/common/dialog_exclamation_mark.svg",
                              width: 50.5,
                              height: 50.5),
                          const SizedBox(height: 27),
                          const Text("mypage_signout_dialog",
                              style: TextStyle(
                                color: HelloColors.mainBlue,
                                fontFamily: HelloFonts.sbAggroOTF,
                                fontSize: 12,
                                height: 20 / 12,
                                letterSpacing: 0.12,
                              )).tr(),
                          const SizedBox(height: 26),
                          Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFEBEBEB),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    child: Center(
                                      child: const Text(
                                        "cancel_button",
                                        style: TextStyle(
                                          color: HelloColors.gray,
                                          fontFamily: HelloFonts.sbAggroOTF,
                                          fontSize: 12,
                                          height: 1.0,
                                        ),
                                      ).tr(),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: InkWell(
                                  onTap: () async {
                                    context.read<SignOutBloc>().add(SignOut());
                                  },
                                  child: Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: HelloColors.mainBlue,
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    child: Center(
                                      child: const Text("confirm_button",
                                          style: TextStyle(
                                            color: HelloColors.subTextColor,
                                            fontFamily: HelloFonts.sbAggroOTF,
                                            fontSize: 12,
                                            height: 1.0,
                                          )).tr(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      )),
                ),
              ),
            );
          }),
        );
      });
}
