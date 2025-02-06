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
                    SplashTextLabel(text: "사용 약관"),
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
                          const SnackBar(content: Text("모든 약관에 동의해야 합니다.")),
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
      "title": "개인정보 처리방침에 동의 (필수)",
      "details": """
    HelloWorld 서비스(이하 "서비스")를 제공하는 개발팀(이하 "팀")은 개인정보 보호를 중요하게 생각하며, 서비스 이용 과정에서 수집되는 개인정보의 처리에 대해 아래와 같이 안내드립니다.

    1. 수집하는 개인정보의 항목
    - 회원가입 시 수집되는 개인정보: 카카오톡 계정 정보, 닉네임
    - 별도로 수집되는 개인정보: 프로필 사진, My Team 정보 등

    2. 개인정보의 처리 목적
    - 서비스 제공 및 회원 관리
    - 부정행위 방지 및 서비스 개선
    - 서비스 이용 통계 수집 및 분석

    3. 개인정보의 처리 및 보유 기간
    - 법령에 따른 개인정보 보유 및 이용기간 내에서 처리 및 보유됩니다.
    - 서비스 이용 후 90일 이내에 개인정보를 파기합니다.

    4. 개인정보의 제3자 제공
    - 회원의 동의 없이 개인정보를 제3자에게 제공하지 않습니다.

    5. 개인정보의 보호 방법
    - 팀은 개인정보 보호를 위해 다양한 보안 기술을 적용하고 있습니다.

    6. 회원의 권리 및 의무
    - 회원은 언제든지 자신의 개인정보를 조회하거나 수정, 삭제할 수 있으며, 개인정보 처리에 관한 권리를 행사할 수 있습니다.

    7. 개인정보의 파기
    - 서비스 이용 중 개인정보 처리 목적이 달성되면 즉시 파기됩니다.
    """,
    },
    {
      "title": "사용약관 처리방침에 동의 (필수)",
      "details": """
    본 약관은 HelloWorld 서비스(이하 "서비스")의 이용에 관한 조건을 규정하며, 서비스 제공 및 회원 간의 권리와 의무를 명시합니다.

    1. 서비스의 제공
    - HelloWorld 서비스는 회원에게 다양한 기능과 콘텐츠를 제공하며, 서비스 이용에 대한 약관을 따릅니다.
    
    2. 회원의 의무
    - 회원은 서비스를 이용하면서 타인의 권리를 침해하거나 서비스의 정상적인 운영을 방해하는 행위를 해서는 안 됩니다.
    - 불법적인 행위, 범죄행위 등 서비스에 해를 끼치는 행위를 할 경우 서비스 이용이 제한될 수 있습니다.

    3. 서비스 이용 제한
    - 팀은 서비스 이용 중 부정행위 또는 약관 위반을 발견한 경우, 해당 회원에 대해 서비스 이용을 제한하거나 계정을 정지할 수 있습니다.

    4. 개인정보 보호
    - 서비스 이용 시 수집되는 개인정보는 팀의 개인정보 처리방침에 따라 처리되며, 회원은 언제든지 개인정보 수정 및 삭제를 요청할 수 있습니다.

    5. 서비스의 변경 및 중단
    - 팀은 기술적 문제나 운영상의 필요로 인해 서비스를 변경하거나 중단할 수 있습니다.
    
    6. 약관의 변경
    - 팀은 서비스의 향상 및 법령의 변경 등을 이유로 약관을 변경할 수 있으며, 변경된 약관은 공지 후 효력을 발생합니다.

    7. 면책 조항
    - 팀은 서비스 이용과 관련하여 발생하는 문제에 대해 법적으로 책임지지 않으며, 회원은 서비스를 이용하는 과정에서 발생할 수 있는 모든 책임을 지게 됩니다.

    8. 법적 준거 및 분쟁 해결
    - 본 약관은 대한민국 법에 따르며, 서비스 이용과 관련된 분쟁은 팀의 소재지 법원을 제1심 법원으로 합니다.
    """
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
                  "모두 동의",
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
                    "세부 정보 보기 >",
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
