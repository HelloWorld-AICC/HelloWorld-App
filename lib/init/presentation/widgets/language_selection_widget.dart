import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:country_icons/country_icons.dart';

class LanguageSelectionWidget extends StatelessWidget {
  final String flagPath;
  final String language;
  final bool isSelected;
  final VoidCallback onTap;

  const LanguageSelectionWidget({
    super.key,
    required this.flagPath,
    required this.language,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
          // border: Border.all(color: const Color(0xFF7AB8C3), width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        height: height * 0.05,
        width: width * 0.5,
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 국기 이미지
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Image.asset(flagPath, package: 'country_icons'),
                ),
                // 언어 텍스트
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      language,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        color: Color(0xff9D9D9D),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                // 체크 버튼
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Icon(
                    isSelected
                        ? Icons.check_circle
                        : Icons.check_circle_outline,
                    color: isSelected ? Color(0xffD2E7FF) : Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
