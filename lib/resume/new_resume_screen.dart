import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hello_world_mvp/design_system/hello_colors.dart';

class ResumeScreen extends StatefulWidget {
  @override
  _ResumeScreenState createState() => _ResumeScreenState();
}

class _ResumeScreenState extends State<ResumeScreen> {
  int currentStep = 0;
  double progress = 0.0;
  bool isButtonActive = false;

  int _maxLength = 2000;
  List _currentLength = [0, 0];

  final List<TextEditingController> controllers =
      List.generate(30, (index) => TextEditingController());
  String? selectedVisa, selectedNationality, selectedGender;

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _updateProgress() {
    setState(() {
      progress = (currentStep + 1) / 7;
      isButtonActive =
          controllers[currentStep].text.isNotEmpty || selectedVisa != null;
    });
  }

  void _nextStep() {
    if (isButtonActive && currentStep < 7) {
      setState(() {
        currentStep++;
        isButtonActive = false;
      });
    }
  }

  void _updateCharacterCnt(int index) {
    setState(() {
      _currentLength[index] = controllers[15].text.length;
    });
  }

  final List<String> subtitles = [
    'resume_page.visa.subtitle',
    'resume_page.visa.subtitle',
    'resume_page.work_experience.subtitle',
    'resume_page.personal_info.subtitle',
    'resume_page.korean_ability.subtitle',
    'resume_page.education.subtitle',
    'resume_page.certificate.subtitle',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: HelloColors.mainBlue,
        body: Stack(
          children: [
            // Background Image
            Positioned(
              top: 80,
              left: 0,
              right: 0,
              bottom: 0,
              child: Image.asset(
                'assets/images/resume/background.png',
                fit: BoxFit.fitHeight,
              ),
            ),
            // Content
            Positioned(
              top: 20,
              left: 0,
              right: 0,
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Column(
                  children: [
                    // Progress Bar (Fixed at the top)
                    LinearProgressIndicator(
                      value: progress,
                      minHeight: 10,
                      backgroundColor: Color(0xffDFEDFD),
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Color(0xffBFDAFC)),
                    ),
                    SizedBox(height: 100),

                    // Title and Subtitle (Fixed)
                    Text(
                      tr('resume_page.resume.title'),
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: HelloColors.mainColor1),
                    ),
                    SizedBox(height: 10),
                    Text(
                      tr(subtitles[currentStep]),
                      style: TextStyle(
                          fontSize: 16, color: HelloColors.subTextColor),
                    ),
                    SizedBox(height: 20),

                    // Scrollable content
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Builder(
                            builder: (_) {
                              if (currentStep == 0)
                                return _buildVisaSelection();
                              if (currentStep == 1) return _buildVisaDetails();
                              if (currentStep == 2)
                                return _buildWorkExperience();
                              if (currentStep == 3) return _buildPersonalInfo();
                              if (currentStep == 4)
                                return _buildKoreanAbility();
                              if (currentStep == 5) return _buildEducation();
                              if (currentStep == 6) return _buildCertificates();
                              return _buildCompleteScreen();
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (currentStep > 0)
                      IconButton(
                        onPressed: () => setState(() {
                          currentStep--;
                          _updateProgress();
                          selectedVisa = null;
                        }),
                        icon: SvgPicture.asset('assets/icons/arrow_left.svg',
                            width: 60, height: 60),
                      ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        isButtonActive ? _nextStep() : null;
                        _updateProgress();
                        selectedVisa = null;
                      },
                      icon: SvgPicture.asset('assets/icons/arrow_right.svg',
                          width: 60, height: 60),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16,
        color: HelloColors.mainColor1,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildDropdownFormField({
    required String? value,
    required String hint,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      hint: Text(
        hint,
        style: TextStyle(color: HelloColors.subTextColor, fontSize: 12),
      ),
      items: items
          .map(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(
                e,
                style: TextStyle(color: HelloColors.subTextColor),
              ),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String labelText,
    required ValueChanged<String> onChanged,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: HelloColors.subTextColor, fontSize: 12),
      ),
      onChanged: onChanged,
    );
  }

  Widget _buildVisaSelection() {
    return Column(
      children: [
        SizedBox(height: 50),
        _buildSelectableButton('resume_page.visa.acquired'.tr(), true),
        SizedBox(height: 10),
        _buildSelectableButton('resume_page.visa.planning'.tr(), false),
      ],
    );
  }

  Widget _buildSelectableButton(String textKey, bool isSelected) {
    return Container(
      width: MediaQuery.of(context).size.width - 40 - 40,
      height: 50,
      child: OutlinedButton(
        onPressed: () {
          setState(() {
            selectedVisa = tr(textKey);
            isButtonActive = true;
          });
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: selectedVisa == tr(textKey)
              ? Color(0xff7FA8DB)
              : HelloColors.white,
          side: BorderSide(
            color: selectedVisa == tr(textKey)
                ? HelloColors.white
                : Color(0xff7FA8DB),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          tr(textKey),
          style: TextStyle(
              color: selectedVisa == tr(textKey)
                  ? Colors.white
                  : Color(0xff7FA8DB)),
        ),
      ),
    );
  }

  Widget _buildVisaDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(tr('resume_page.visa.select_visa_title')),
        _buildDropdownFormField(
          value: selectedVisa,
          hint: tr('resume_page.visa.select_visa'),
          items: ["A-1", "A-2"],
          onChanged: (val) => setState(() => selectedVisa = val),
        ),
        SizedBox(height: 20),
        _buildSectionTitle(tr('resume_page.visa.issue_date')),
        _buildTextFormField(
          controller: controllers[0],
          labelText: tr('resume_page.visa.issue_date'),
          onChanged: (_) => _updateProgress(),
        ),
        SizedBox(height: 20),
        _buildSectionTitle(tr('resume_page.visa.expiry_date')),
        _buildTextFormField(
          controller: controllers[1],
          labelText: tr('resume_page.visa.expiry_date'),
          onChanged: (_) => _updateProgress(),
        ),
      ],
    );
  }

  Widget _buildWorkExperience() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(
            tr('resume_page.work_experience.company_name_title')),
        _buildTextFormField(
          controller: controllers[2],
          labelText: tr('resume_page.work_experience.company_name'),
          onChanged: (_) => _updateProgress(),
        ),
        SizedBox(height: 20),
        _buildSectionTitle(tr('resume_page.work_experience.job_title_title')),
        _buildTextFormField(
          controller: controllers[3],
          labelText: tr('resume_page.work_experience.job_title'),
          onChanged: (_) => _updateProgress(),
        ),
        SizedBox(height: 20),
        _buildSectionTitle(tr('resume_page.work_experience.start_date')),
        _buildTextFormField(
          controller: controllers[4],
          labelText: tr('resume_page.work_experience.start_date'),
          onChanged: (_) => _updateProgress(),
        ),
        SizedBox(height: 20),
        _buildSectionTitle(tr('resume_page.work_experience.end_date')),
        _buildTextFormField(
          controller: controllers[5],
          labelText: tr('resume_page.work_experience.end_date'),
          onChanged: (_) => _updateProgress(),
        ),
      ],
    );
  }

  Widget _buildPersonalInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(tr('resume_page.personal_info.nationality')),
        _buildDropdownFormField(
          value: selectedVisa,
          hint: tr('resume_page.personal_info.select_nationality'),
          items: [
            "countries.korea".tr(),
            "countries.japan".tr(),
            "countries.china".tr(),
            "countries.vietnam".tr(),
            "countries.usa".tr()
          ],
          onChanged: (val) => setState(() => selectedVisa = val),
        ),
        SizedBox(height: 20),
        _buildSectionTitle(tr('resume_page.personal_info.birth_date')),
        _buildTextFormField(
          controller: controllers[6],
          labelText: tr('resume_page.personal_info.birth_date'),
          onChanged: (_) => _updateProgress(),
        ),
        SizedBox(height: 20),
        _buildSectionTitle(tr('resume_page.personal_info.residence')),
        _buildTextFormField(
          controller: controllers[7],
          labelText: tr('resume_page.personal_info.residence'),
          onChanged: (_) => _updateProgress(),
        ),
        SizedBox(height: 20),
        _buildSectionTitle(tr('resume_page.personal_info.email')),
        _buildTextFormField(
          controller: controllers[8],
          labelText: tr('resume_page.personal_info.email'),
          onChanged: (_) => _updateProgress(),
        ),
      ],
    );
  }

  Widget _buildKoreanAbility() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(tr('resume_page.korean_ability.test_name')),
        _buildTextFormField(
          controller: controllers[9],
          labelText: tr('resume_page.korean_ability.test_name'),
          onChanged: (_) => _updateProgress(),
        ),
        SizedBox(height: 20),
        _buildSectionTitle(tr('resume_page.korean_ability.score')),
        _buildTextFormField(
          controller: controllers[10],
          labelText: tr('resume_page.korean_ability.score'),
          onChanged: (_) => _updateProgress(),
        ),
      ],
    );
  }

  Widget _buildEducation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(tr('resume_page.education.school_name')),
        _buildTextFormField(
          controller: controllers[11],
          labelText: tr('resume_page.education.school_name'),
          onChanged: (_) => _updateProgress(),
        ),
        SizedBox(height: 20),
        _buildSectionTitle(tr('resume_page.education.major')),
        _buildTextFormField(
          controller: controllers[12],
          labelText: tr('resume_page.education.major'),
          onChanged: (_) => _updateProgress(),
        ),
        SizedBox(height: 20),
        _buildSectionTitle(tr('resume_page.education.start_date')),
        _buildTextFormField(
          controller: controllers[13],
          labelText: tr('resume_page.education.start_date'),
          onChanged: (_) => _updateProgress(),
        ),
        SizedBox(height: 20),
        _buildSectionTitle(tr('resume_page.education.end_date')),
        _buildTextFormField(
          controller: controllers[14],
          labelText: tr('resume_page.education.end_date'),
          onChanged: (_) => _updateProgress(),
        ),
        SizedBox(height: 20),
        _buildSectionTitle(tr('main_content')),
        _buildTextFormField(
            controller: controllers[15],
            labelText: tr('resume_page.education.main_content'),
            onChanged: (_) {
              _updateProgress();
              _updateCharacterCnt(0);
            }),
        SizedBox(height: 8),
        Text(
          'Characters: ${_currentLength[0]}/$_maxLength',
          style: TextStyle(
            color: _currentLength[0] > _maxLength ? Colors.red : Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildCertificates() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(tr('resume_page.certificate.name').tr()),
        _buildTextFormField(
          controller: controllers[16],
          labelText: tr('resume_page.certificate.name'),
          onChanged: (_) => _updateProgress(),
        ),
        SizedBox(height: 20),
        _buildSectionTitle(tr('resume_page.certificate.organization').tr()),
        _buildTextFormField(
          controller: controllers[17],
          labelText: tr('resume_page.certificate.organization'),
          onChanged: (_) => _updateProgress(),
        ),
        SizedBox(height: 20),
        _buildSectionTitle(tr('resume_page.certificate.acquisition_date').tr()),
        _buildTextFormField(
          controller: controllers[18],
          labelText: tr('resume_page.certificate.acquisition_date'),
          onChanged: (_) => _updateProgress(),
        ),
        SizedBox(height: 20),
        _buildSectionTitle(tr('resume_page.certificate.expiry_date').tr()),
        _buildTextFormField(
          controller: controllers[19],
          labelText: tr('resume_page.certificate.expiry_date'),
          onChanged: (_) => _updateProgress(),
        ),
        SizedBox(height: 20),
        _buildSectionTitle(tr('main_content')),
        _buildTextFormField(
            controller: controllers[20],
            labelText: tr('resume_page.certificate.main_content'),
            onChanged: (_) {
              _updateProgress();
              _updateCharacterCnt(1);
            }),
        SizedBox(height: 8),
        Text(
          'Characters: ${_currentLength[1]}/$_maxLength',
          style: TextStyle(
            color: _currentLength[1] > _maxLength ? Colors.red : Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildCompleteScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.check_circle, color: HelloColors.subTextColor, size: 80),
          SizedBox(height: 20),
          Text(
            tr('resume_page.complete_message'),
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              setState(() {
                currentStep = 0; // 처음으로 되돌리기
                progress = 0.0;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: HelloColors.subTextColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(tr('resume_page.restart'),
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
