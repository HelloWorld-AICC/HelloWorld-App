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

  final List<TextEditingController> controllers =
      List.generate(10, (index) => TextEditingController());
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
    if (isButtonActive && currentStep < 6) {
      setState(() {
        currentStep++;
        isButtonActive = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false, // Set to false to avoid resizing
        backgroundColor: HelloColors.mainBlue,
        body: Stack(
          children: [
            // Background Image
            Positioned(
              top: 80,
              // Starts below the SizedBox
              left: 0,
              right: 0,
              bottom: 0,
              child: Image.asset(
                'assets/images/resume/background.png',
                fit: BoxFit.fitHeight,
              ),
            ),
            // Your content on top of the image
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Column(
                children: [
                  LinearProgressIndicator(
                    value: progress,
                    minHeight: 10,
                    backgroundColor: Color(0xffDFEDFD),
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xffBFDAFC)),
                  ),
                  SizedBox(height: 100),
                  Text(
                    tr('resume_page.resume.title'),
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: HelloColors.mainColor1),
                  ),
                  SizedBox(height: 10),
                  Text(
                    tr('resume_page.visa.subtitle'),
                    style: TextStyle(
                        fontSize: 16, color: HelloColors.subTextColor),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Builder(
                      builder: (_) {
                        if (currentStep == 0) return _buildVisaSelection();
                        if (currentStep == 1) return _buildVisaDetails();
                        if (currentStep == 2) return _buildWorkExperience();
                        if (currentStep == 3) return _buildPersonalInfo();
                        if (currentStep == 4) return _buildKoreanAbility();
                        if (currentStep == 5) return _buildEducation();
                        if (currentStep == 6) return _buildCertificates();
                        return SizedBox(); // Return an empty widget if no condition is met
                      },
                    ),
                  ),
                  Spacer(),
                  Row(
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
                ],
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
        _buildSelectableButton('resume_page.visa.acquired', true),
        SizedBox(height: 10),
        _buildSelectableButton('resume_page.visa.planning', false),
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
        _buildSectionTitle(tr('resume_page.visa.company_name_title')),
        _buildTextFormField(
          controller: controllers[2],
          labelText: tr('resume_page.work_experience.company_name'),
          onChanged: (_) => _updateProgress(),
        ),
        SizedBox(height: 20),
        _buildSectionTitle(tr('resume_page.visa.job_title_title')),
        _buildTextFormField(
          controller: controllers[3],
          labelText: tr('resume_page.work_experience.job_title'),
          onChanged: (_) => _updateProgress(),
        ),
      ],
    );
  }

  Widget _buildPersonalInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(tr('resume_page.personal_info.birth_date')),
        _buildTextFormField(
          controller: controllers[4],
          labelText: tr('resume_page.personal_info.birth_date'),
          onChanged: (_) => _updateProgress(),
        ),
        SizedBox(height: 20),
        _buildSectionTitle(tr('resume_page.personal_info.email')),
        _buildTextFormField(
          controller: controllers[5],
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
          controller: controllers[6],
          labelText: tr('resume_page.korean_ability.test_name'),
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
          controller: controllers[7],
          labelText: tr('resume_page.education.school_name'),
          onChanged: (_) => _updateProgress(),
        ),
      ],
    );
  }

  Widget _buildCertificates() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(tr('resume_page.certificate.name')),
        _buildTextFormField(
          controller: controllers[8],
          labelText: tr('resume_page.certificate.name'),
          onChanged: (_) => _updateProgress(),
        ),
      ],
    );
  }
}
