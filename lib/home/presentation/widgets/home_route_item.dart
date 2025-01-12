import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_world_mvp/toast/common_toast.dart';

import '../../../design_system/hello_colors.dart';
import '../../../injection.dart';
import '../../../route/application/route_bloc.dart';
import '../../../route/domain/route_service.dart';

class HomeRouteItem extends StatelessWidget {
  final String title;
  final String subTitle;
  final String imgPath;
  final int bottomIndex;
  final RouteService routeService;
  final String routePath;
  final Alignment imgAlign;
  final double imgWidth;
  final double imgHeight;
  final bool isBeta;

  HomeRouteItem({
    Key? key,
    required this.routeService,
    required this.title,
    required this.subTitle,
    required this.imgPath,
    required this.bottomIndex,
    required this.routePath,
    required this.imgWidth,
    required this.imgHeight,
    required this.isBeta,
    required this.imgAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (routePath == "callbot") {
          showToast("미구현 기능입니다.");
          return;
        }
        context
            .read<RouteBloc>()
            .add(RouteChanged(newIndex: bottomIndex, newRoute: routePath));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(
            color: const Color(0xFFE2E2E2), // 적용할 stroke 색상
            width: 1.0, // stroke 두께
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFB2B2F0).withOpacity(0.08),
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: "SB AggroOTF",
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      color: isBeta
                          ? HelloColors.subTextColor
                          : HelloColors.mainColor1,
                    ),
                  ).tr(),
                  const SizedBox(height: 3),
                  Text(
                    subTitle,
                    style: TextStyle(
                      fontFamily: "SB AggroOTF",
                      fontSize: 6,
                      fontWeight: FontWeight.normal,
                      color: isBeta
                          ? HelloColors.subTextColor
                          : HelloColors.mainColor1,
                    ),
                  ).tr(),
                ],
              ),
            ),
            Expanded(
              child: Container(
                alignment: imgAlign,
                child: Image.asset(
                  imgPath,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
