import 'package:flutter/material.dart';
import 'package:hello_world_mvp/design_system/hello_colors.dart';
import 'package:hello_world_mvp/design_system/hello_fonts.dart';

class BoardTab extends StatelessWidget {
  final String title;
  final Function onTap;
  final bool isSelected;
  const BoardTab({
    super.key,
    required this.title,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: InkWell(
        onTap: () => onTap(),
        child: Text(title,
            style: TextStyle(
              color: isSelected
                  ? HelloColors.subTextColor
                  : const Color(0xFFB2B2B2),
              fontFamily: HelloFonts.sbAggroOTF,
              fontSize: 12,
              height: 16 / 12,
            )),
      ),
    );
  }
}
