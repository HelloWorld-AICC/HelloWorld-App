import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CreateResumeScreen extends StatelessWidget {
  final double paddingVal;

  const CreateResumeScreen({super.key, required this.paddingVal});

  static const resumeSections = [
    {
      'title': 'experienceTitle',
      'content': [
        'Hyundai',
        '2022.01 ~ 2024.08',
        '소프트웨어 인턴',
        '1. Improved app performance by identifying and fixing bugs, resulting in a 15% increase in app speed.',
        '2. Contributed to the successful implementation of a new feature, leading to a 20% increase in user engagement.',
        '3. Enhanced app stability by conducting thorough testing and resolving critical issues, reducing crashes by 25%.',
      ],
    },
    {
      'title': 'educationTitle',
      'content': [
        'Seoul National University',
        '2017.03 ~ 2021.02',
        '컴퓨터 공학과 학사',
        '1. Participated in research on machine learning algorithms.',
        '2. Developed a mobile app as part of a senior project, which was awarded the best project in the class.',
        '3. Completed coursework in data structures, algorithms, and software engineering with top grades.',
      ],
    },
    {
      'title': 'skillsTitle',
      'content': [
        '프로그래밍 언어: Dart, Java, Python',
        '프레임워크: Flutter, Spring Boot',
        '데이터베이스: MySQL, MongoDB',
        '도구: Git, Docker, Jenkins',
        '기타: RESTful APIs, Agile Development',
      ],
    },
    {
      'title': 'certificationsTitle',
      'content': [
        'Google Certified Associate Android Developer',
        'AWS Certified Solutions Architect – Associate',
        'Certified ScrumMaster (CSM)',
      ],
    },
    {
      'title': 'projectsTitle',
      'content': [
        'Project A: Flutter 기반의 쇼핑 앱 개발',
        '기간: 2023.03 ~ 2023.12',
        '설명: 사용자 친화적인 UI를 갖춘 쇼핑 앱을 개발했습니다. 주요 기능으로는 장바구니, 주문 추적, 사용자 리뷰 시스템이 포함됩니다.',
        '기여: 앱의 프론트엔드 및 백엔드 개발, API 통합',
        '',
        'Project B: Machine Learning 기반의 추천 시스템',
        '기간: 2022.06 ~ 2022.12',
        '설명: 사용자의 행동을 분석하여 개인화된 추천을 제공하는 시스템을 개발했습니다. 데이터 분석 및 모델 훈련을 수행했습니다.',
        '기여: 데이터 전처리, 모델 훈련 및 평가, 결과 분석',
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16 * paddingVal / 70),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildButton(context),
            buildTextField(),
            buildInfoSection(
              title: "infoSectionTitle".tr(),
              items: [
                "phone".tr(),
                "email".tr(),
              ],
              paddingVal: paddingVal,
            ),
            ...resumeSections.map((section) {
              return buildSection(
                title: (section['title']! as String).tr(),
                content: (section['content'] as List<String>)
                    .map((item) => item.tr())
                    .toList(),
                paddingVal: paddingVal,
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget buildButton(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      margin: EdgeInsets.only(bottom: 16 * paddingVal / 100),
      child: ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
          backgroundColor:
              WidgetStateProperty.all<Color>(const Color(0xff3369FF)),
        ),
        child: Text(
          "buttonText".tr(),
          style: TextStyle(
            fontSize: 16 * paddingVal / 100,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget buildTextField() {
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(bottom: 16 * paddingVal / 100),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'textFieldHint'.tr(),
          hintStyle: TextStyle(
            fontSize: 24 * paddingVal / 100,
            fontWeight: FontWeight.bold,
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
              width: 2.0,
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInfoSection({
    required String title,
    required List<String> items,
    required double paddingVal,
  }) {
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(bottom: 30 * paddingVal / 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16 * paddingVal / 100,
            ),
          ),
          ...items.map((item) => Text(
                item,
                style: TextStyle(
                  fontSize: 16 * paddingVal / 100,
                ),
              )),
        ],
      ),
    );
  }

  Widget buildSection({
    required String title,
    required List<String> content,
    required double paddingVal,
  }) {
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(bottom: 30 * paddingVal / 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20 * paddingVal / 100,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(
            color: Colors.grey,
            thickness: 2.0,
          ),
          ...content.map((item) => Text(
                item,
                style: TextStyle(
                  fontSize: 16 * paddingVal / 100,
                ),
              )),
        ],
      ),
    );
  }
}
