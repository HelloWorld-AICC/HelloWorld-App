import 'package:flutter/material.dart';

class CustomBlueButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isOutlined;

  const CustomBlueButton({
    required this.text,
    required this.onPressed,
    this.isOutlined = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final dynamicPadding = EdgeInsets.symmetric(
      vertical: screenHeight * 0.01,
      horizontal: screenWidth * 0.03,
    );

    final dynamicMargin = EdgeInsets.symmetric(
      vertical: screenHeight * 0.01, // 1% of screen height
      horizontal: screenWidth * 0.01, // 2% of screen width
    );

    return GestureDetector(
      onTap: onPressed,
      child: IntrinsicWidth(
        child: IntrinsicHeight(
          child: Container(
            padding: dynamicPadding,
            margin: dynamicMargin,
            decoration: BoxDecoration(
              color: isOutlined ? Colors.white : const Color(0xFF1777E9),
              borderRadius: BorderRadius.circular(12),
              border: isOutlined
                  ? Border.all(color: const Color(0xFF1777E9), width: 1.5)
                  : null,
            ),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  color: isOutlined ? const Color(0xFF1777E9) : Colors.white,
                  fontSize: MediaQuery.of(context).size.width *
                      0.04, // 4% of screen width
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
