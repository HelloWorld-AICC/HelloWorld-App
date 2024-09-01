import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LanguageChoiceChips extends StatefulWidget {
  const LanguageChoiceChips({super.key});

  @override
  _LanguageChoiceChipsState createState() => _LanguageChoiceChipsState();
}

class _LanguageChoiceChipsState extends State<LanguageChoiceChips> {
  final List<String> _languages = [
    "languages.english",
    "languages.korean",
    "languages.japanese",
    "languages.chinese",
    "languages.vietnamese"
  ];
  String _selectedLanguage = "";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        scrollDirection: Axis.horizontal, // 수평 스크롤 활성화
        children: _languages.map((languageKey) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: ChoiceChip(
              label: Text(languageKey.tr()),
              selected: _selectedLanguage == languageKey,
              onSelected: (bool selected) {
                setState(() {
                  _selectedLanguage = selected ? languageKey : "";
                });
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}
