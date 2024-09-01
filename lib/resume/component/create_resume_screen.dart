import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CreateResumeScreen extends StatefulWidget {
  final double paddingVal;

  const CreateResumeScreen({super.key, required this.paddingVal});

  @override
  State<CreateResumeScreen> createState() => _CreateResumeScreenState();
}

class _CreateResumeScreenState extends State<CreateResumeScreen> {
  // Function to fetch the localized experience detail by index
  String getExperienceDetail(int index) {
    return 'resume.experience.details.detail${index + 1}'.tr();
  }

  List<String> selectedKeywords = [];

  void _showKeywordsDialog(BuildContext context) {
    // Define the JSON data
    final Map<String, Map<String, String>> keywordsData = {
      "Professional Experience": {
        "detail0": "Performance Optimization",
        "detail1": "Feature Implementation",
        "detail2": "Bug Fixing",
        "detail3": "App Stability",
        "detail4": "Testing & Debugging"
      },
      "Education": {
        "detail0": "Machine Learning Algorithms",
        "detail1": "Mobile App Development",
        "detail2": "Data Structures",
        "detail3": "Algorithms",
        "detail4": "Software Engineering"
      },
      "Skills": {
        "detail0": "Dart",
        "detail1": "Java",
        "detail2": "Python",
        "detail3": "Flutter",
        "detail4": "Spring Boot",
        "detail5": "MySQL",
        "detail6": "MongoDB",
        "detail7": "Git",
        "detail8": "Docker",
        "detail9": "Jenkins",
        "detail10": "RESTful APIs",
        "detail11": "Agile Development"
      },
      "Certifications": {
        "detail0": "Google Associate Android Developer",
        "detail1": "AWS Certified Solutions Architect – Associate",
        "detail2": "Certified Scrum Master (CSM)"
      },
      "Projects": {
        "detail0": "Flutter",
        "detail1": "Shopping App Development",
        "detail2": "User-Friendly UI",
        "detail3": "Cart Management",
        "detail4": "Order Tracking",
        "detail5": "User Reviews",
        "detail6": "Machine Learning",
        "detail7": "Recommendation System",
        "detail8": "Data Analysis",
        "detail9": "Model Training"
      }
    };

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text(tr("keywords")),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: keywordsData.entries.map((categoryEntry) {
                    final category = categoryEntry.key;
                    final keywords = categoryEntry.value;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            category,
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          const SizedBox(height: 8.0),
                          Wrap(
                            spacing: 8.0, // Horizontal space between chips
                            runSpacing: 8.0, // Vertical space between lines
                            children: keywords.entries.map((keywordEntry) {
                              final keyword = keywordEntry.value;
                              final isSelected =
                                  selectedKeywords.contains(keyword);
                              return FilterChip(
                                label: Text(
                                  keyword,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                selected: selectedKeywords.contains(keyword),
                                onSelected: (selected) {
                                  setState(() {
                                    if (selected) {
                                      if (!selectedKeywords.contains(keyword)) {
                                        selectedKeywords.add(keyword);
                                      }
                                    } else {
                                      selectedKeywords.remove(keyword);
                                    }
                                  });
                                },
                                backgroundColor: Colors.grey[200],
                                selectedColor:
                                    const Color.fromARGB(255, 149, 171, 233),
                                labelStyle: TextStyle(
                                  color:
                                      isSelected ? Colors.white : Colors.black,
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text("Close"),
                  onPressed: () {
                    // 선택된 키워드를 콘솔에 출력하거나 다른 방식으로 처리할 수 있습니다.
                    print("Selected Keywords: $selectedKeywords");
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
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
        padding: EdgeInsets.all(16 * widget.paddingVal / 70),
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
              paddingVal: widget.paddingVal,
            ),
            ...resumeSections.map((section) {
              return buildSection(
                title: (section['title']! as String).tr(),
                content: (section['content'] as List<String>)
                    .map((item) => item.tr())
                    .toList(),
                paddingVal: widget.paddingVal,
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
      margin: EdgeInsets.only(bottom: 16 * widget.paddingVal / 100),
      child: ElevatedButton(
        onPressed: () {
          _showKeywordsDialog(context);
        },
        style: ButtonStyle(
          backgroundColor:
              WidgetStateProperty.all<Color>(const Color(0xff3369FF)),
        ),
        child: Text(
          "Show Keywords",
          style: TextStyle(
            fontSize: 16 * widget.paddingVal / 100,
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
      margin: EdgeInsets.only(bottom: 16 * widget.paddingVal / 100),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'textFieldHint'.tr(),
          hintStyle: TextStyle(
            fontSize: 24 * widget.paddingVal / 100,
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
