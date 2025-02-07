import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_world_mvp/design_system/hello_colors.dart';
import 'package:hello_world_mvp/init/application/app_init_bloc.dart';
import 'package:hello_world_mvp/init/presentation/widgets/splash_text_label.dart';

import '../../auth/application/status/auth_status_bloc.dart';

class TermsOfServicePage extends StatefulWidget {
  @override
  _TermsOfServicePageState createState() => _TermsOfServicePageState();
}

class _TermsOfServicePageState extends State<TermsOfServicePage> {
  bool allSelected = false;
  List<bool> selections = [false, false];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              // 배경 도형
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xffECF6FE),
                ),
              ),
              // 큰 원
              Positioned(
                bottom: -MediaQuery.of(context).size.height / 6,
                left: MediaQuery.of(context).size.width / 2 - 400,
                child: ClipOval(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: Container(
                      width: 800,
                      height: 800,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              HelloColors.white.withOpacity(0.8),
                              HelloColors.mainBlue.withOpacity(0.01),
                            ],
                            stops: const [
                              0.2,
                              0.8
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter),
                      ),
                    ),
                  ),
                ),
              ),

              Positioned(
                top: MediaQuery.of(context).size.height / 8,
                left: MediaQuery.of(context).size.width / 8,
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 5,
                      child: Image.asset(
                        'assets/images/home/Nice to meet you.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SplashTextLabel(text: "terms_page.title".tr()),
                    const SizedBox(height: 20),
                    TermsContent(
                      onAllTermsAccepted: (bool isAccepted) {
                        setState(() {
                          allSelected = isAccepted;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 1.16,
                left: MediaQuery.of(context).size.width / 1.5,
                right: 0,
                child: Padding(
                  padding: EdgeInsets.only(left: 30.0, right: 30.0),
                  child: GestureDetector(
                    onTap: () async {
                      if (!allSelected) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("terms_page.snackbar".tr())),
                        );
                        return;
                      }
                      context.read<AppInitBloc>().add(MarkAppRunnedBefore());
                      final isSignIn =
                          context.read<AuthStatusBloc>().state.isSignedIn;

                      if (isSignIn == null || !isSignIn) {
                        context.push('/login');
                        return;
                      } else {
                        context.push('/home');
                      }
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: const BoxDecoration(
                            color: Color(0xffB7D3F6),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_rounded,
                          size: 45,
                          color: HelloColors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TermsContent extends StatefulWidget {
  final Function(bool) onAllTermsAccepted;

  TermsContent({required this.onAllTermsAccepted});

  @override
  _TermsContentState createState() => _TermsContentState();
}

class _TermsContentState extends State<TermsContent> {
  List<bool> selections = [];

  final List<Map<String, String>> terms = [
    {
      "title": "terms_page.privacy_policy".tr(),
      "details": "terms_page.privacy_policy_details".tr(),
    },
    {
      "title": "terms_page.terms_of_service".tr(),
      "details": "terms_page.terms_of_service_details".tr(),
    }
  ];

  @override
  void initState() {
    super.initState();
    selections = List.generate(terms.length, (index) => false);
  }

  void toggleAllSelected(bool? value) {
    setState(() {
      final isSelected = value ?? false;
      for (int i = 0; i < selections.length; i++) {
        selections[i] = isSelected;
      }
      widget.onAllTermsAccepted(isSelected);
    });
  }

  void toggleIndividualCheckbox(int index, bool? value) {
    setState(() {
      selections[index] = value ?? false;
      final allAccepted = selections.every((isSelected) => isSelected);
      widget.onAllTermsAccepted(allAccepted);
    });
  }

  void showDetailsPopup(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      barrierColor: const Color(0xCC000000),
      builder: (context) => AlertDialog(
        backgroundColor: HelloColors.white,
        contentPadding: const EdgeInsets.all(30),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Image.asset("assets/images/home/exclamation_point.png"),
                const SizedBox(height: 20),
                Text(
                  title,
                  style: const TextStyle(
                      color: HelloColors.mainColor1,
                      fontFamily: 'SB AggroOTF',
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Flexible(
              flex: 1,
              child: SingleChildScrollView(
                child: Text(content,
                    style: const TextStyle(
                      fontFamily: 'SB AggroOTF',
                      fontSize: 8,
                    )),
              ),
            ),
          ],
        ),
        actions: [
          Center(
            child: TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(
                backgroundColor: HelloColors.mainBlue,
                minimumSize: Size(MediaQuery.of(context).size.width * 0.3, 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "확인",
                style: const TextStyle(
                  color: HelloColors.subTextColor,
                  fontFamily: 'SB AggroOTF',
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Text(
                  "terms_page.all_agree".tr(),
                  style: TextStyle(
                    fontFamily: "SB AggroOTF",
                    fontWeight: FontWeight.bold,
                    color: HelloColors.mainColor1,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: CustomCheckbox(
                  value: selections.every((isSelected) => isSelected),
                  onChanged: toggleAllSelected,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Divider(),
          ...List.generate(terms.length, (index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Text(
                        terms[index]["title"]!,
                        style: TextStyle(
                          fontFamily: 'SB AggroOTF',
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: HelloColors.mainColor1,
                        ),
                      ),
                    ),
                    Container(
                        alignment: Alignment.centerRight,
                        child: CustomCheckbox(
                          value: selections[index],
                          onChanged: (bool? newValue) {
                            toggleIndividualCheckbox(index, newValue);
                          },
                        )),
                  ],
                ),
                SizedBox(height: 5),
                GestureDetector(
                  onTap: () => showDetailsPopup(
                    context,
                    terms[index]["title"]!,
                    terms[index]["details"]!,
                  ),
                  child: Text(
                    "terms_page.look_details".tr(),
                    style: TextStyle(
                      fontFamily: 'SB AggroOTF',
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: HelloColors.subTextColor,
                    ),
                  ),
                ),
                Divider(),
              ],
            );
          }),
        ],
      ),
    );
  }
}

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  CustomCheckbox({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: () => onChanged(!value),
          child: Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: value ? HelloColors.mainBlue : HelloColors.mainBlue,
            ),
            child: Icon(
              Icons.check_rounded,
              color: value ? HelloColors.mainColor1 : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
