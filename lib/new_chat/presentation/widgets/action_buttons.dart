import 'package:flutter/material.dart';

class ActionButtonsWidget extends StatelessWidget {
  final Function(String) onButtonPressed;

  const ActionButtonsWidget({
    Key? key,
    required this.onButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonContents = [
      'Law',
      'Visa',
      'Employment',
      'Living',
    ];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: buttonContents.map((content) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: _buildCustomButton(
            text: content,
            onPressed: () => onButtonPressed(content),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCustomButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: 130,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}
