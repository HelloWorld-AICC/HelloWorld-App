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
    return GestureDetector(
      onTap: onPressed,
      child: IntrinsicWidth(
        child: IntrinsicHeight(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
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
                  fontSize: 16,
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
