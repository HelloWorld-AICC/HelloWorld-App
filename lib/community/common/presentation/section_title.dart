import 'package:flutter/material.dart';
import 'package:hello_world_mvp/design_system/hello_colors.dart';
import 'package:hello_world_mvp/design_system/hello_fonts.dart';

class SectionTitle extends StatelessWidget {
  final String text;
  const SectionTitle({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: const TextStyle(
          fontFamily: HelloFonts.inter,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.16,
          color: HelloColors.subTextColor,
        ));
  }
}
