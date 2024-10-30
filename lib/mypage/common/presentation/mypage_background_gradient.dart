import 'package:flutter/material.dart';

class MypageBackgroundGradient extends StatelessWidget {
  final Widget child;

  const MypageBackgroundGradient({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 858,
          width: 858,
          // color: Colors.red,
          decoration: const BoxDecoration(
            shape: BoxShape.circle, // border-radius: 858px와 유사한 원형 모양
            gradient: RadialGradient(
              center: Alignment.center, // 그라데이션 중심을 컨테이너의 중앙으로 설정
              radius: 0.5, // 그라데이션 반지름
              colors: [
                Color.fromRGBO(
                    168, 196, 230, 0.20), // rgba(168, 196, 230, 0.20)
                Color.fromRGBO(
                    173, 199, 231, 0.19), // rgba(173, 199, 231, 0.19)
                Color.fromRGBO(
                    214, 227, 243, 0.09), // rgba(214, 227, 243, 0.09)
                Color.fromRGBO(
                    255, 255, 255, 0.00), // rgba(255, 255, 255, 0.00)
              ],
              stops: [0.0, 0.2372, 0.6772, 1.0], // 각 색상이 적용될 비율
            ),
          ),
        ),
        child,
      ],
    );
  }
}
