import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CreateResumeScreen extends StatelessWidget {
  final double paddingVal;

  const CreateResumeScreen({super.key, required this.paddingVal});

  // Function to fetch the localized experience detail by index
  String getExperienceDetail(int index) {
    return 'resume.experience.details.detail${index + 1}'.tr();
  }

  @override
  Widget build(BuildContext context) {
    final resumeSections = [
      {
        'title': 'resume.experienceTitle'.tr(),
        'content': [
          'resume.experience.company'.tr(),
          'resume.experience.duration'.tr(),
          'resume.experience.position'.tr(),
          '1. ${'resume.experience.details.detail1'.tr()}',
          '2. ${'resume.experience.details.detail2'.tr()}',
          '3. ${'resume.experience.details.detail3'.tr()}',
        ],
      },
      {
        'title': 'resume.educationTitle'.tr(),
        'content': [
          'resume.education.institution'.tr(),
          'resume.education.duration'.tr(),
          'resume.education.degree'.tr(),
          '1. ${'resume.education.details.detail1'.tr()}',
          '2. ${'resume.education.details.detail2'.tr()}',
          '3. ${'resume.education.details.detail3'.tr()}',
        ],
      },
      {
        'title': 'resume.skillsTitle'.tr(),
        'content': [
          'resume.skills.languages'.tr(),
          'resume.skills.frameworks'.tr(),
          'resume.skills.databases'.tr(),
          'resume.skills.tools'.tr(),
          'resume.skills.others'.tr(),
        ],
      },
      {
        'title': 'resume.certificationsTitle'.tr(),
        'content': [
          'resume.certifications.cert1'.tr(),
          'resume.certifications.cert2'.tr(),
          'resume.certifications.cert3'.tr(),
        ],
      },
      {
        'title': 'resume.projectsTitle'.tr(),
        'content': [
          'resume.projects.projectA.title'.tr(),
          'resume.projects.projectA.duration'.tr(),
          'resume.projects.projectA.description'.tr(),
          'resume.projects.projectA.contribution'.tr(),
          '',
          'resume.projects.projectB.title'.tr(),
          'resume.projects.projectB.duration'.tr(),
          'resume.projects.projectB.description'.tr(),
          'resume.projects.projectB.contribution'.tr(),
        ],
      },
    ];

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
