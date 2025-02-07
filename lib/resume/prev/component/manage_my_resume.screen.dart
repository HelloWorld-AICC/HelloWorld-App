import 'package:flutter/material.dart';

class ManageMyResumeScreen extends StatelessWidget {
  final double paddingVal;

  const ManageMyResumeScreen({super.key, required this.paddingVal});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.construction,
              size: 100,
              color: Colors.orange,
            ),
          ],
        ),
      ),
    );
  }
}
