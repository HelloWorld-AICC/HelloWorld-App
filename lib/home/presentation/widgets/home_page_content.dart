import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_world_mvp/route/domain/service/route_service.dart';

import '../../../custom_bottom_navigationbar.dart';
import '../../../design_system/hello_colors.dart';
import '../../../locale/application/locale_bloc.dart';
import '../../../locale/domain/localization_service.dart';
import 'home_route_grid.dart';

class HomePageContent extends StatelessWidget {
  final List<String> imagesPath;

  HomePageContent({
    Key? key,
    required this.imagesPath,
  }) : super(key: key);

  final routeBoxItems = {
    "center": {
      "title": "home_grid.center.title",
      "subTitle": "home_grid.center.subtitle",
      "imgPath": "assets/images/home/grid_view/offline_center.png",
      "bottom_index": 4,
      "isBeta": false,
    },
    "community": {
      "title": "home_grid.community.title",
      "subTitle": "home_grid.community.subtitle",
      "imgPath": "assets/images/home/grid_view/community.png",
      "bottom_index": 3,
      "isBeta": false,
    },
    "resume": {
      "title": "home_grid.resume.title",
      "subTitle": "home_grid.resume.subtitle",
      "imgPath": "assets/images/home/grid_view/resume.png",
      "bottom_index": 1,
      "isBeta": true,
    },
    "chat": {
      "title": "home_grid.chat.title",
      "subTitle": "home_grid.chat.subtitle",
      "imgPath": "assets/images/home/grid_view/chat.png",
      "bottom_index": 0,
      "isBeta": false,
    },
    "callbot": {
      "title": "home_grid.call_bot.title",
      "subTitle": "home_grid.call_bot.subtitle",
      "imgPath": "assets/images/home/grid_view/call_bot.png",
      "bottom_index": 2,
      "isBeta": false,
    },
  };

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleBloc, LocaleState>(
      builder: (context, state) {
        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFD1E6FF),
                  Color(0xFFDDEDFF),
                  Color(0xFFFFFFFF),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.sizeOf(context).width * 0.05,
                  right: MediaQuery.sizeOf(context).width * 0.05,
                  top: MediaQuery.sizeOf(context).height * 0.05),
              child: Stack(
                children: [
                  Stack(
                    children: [
                      Positioned(
                        top: 60,
                        child: Padding(
                          padding: const EdgeInsets.all(30),
                          child: ClipRect(
                            child: Align(
                              alignment: Alignment.topCenter,
                              heightFactor: 0.3,
                              child: Image.asset(
                                'assets/images/home/nice_to_meet_you_with_sphere.png',
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width / 0.9,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 60,
                        child: ClipRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.01), // 배경색
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 10,
                    child: _buildHeader(context),
                  ),
                  Positioned(
                    top: MediaQuery.sizeOf(context).height * 0.3,
                    child: HomeRouteGrid(
                      items: routeBoxItems,
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: CustomBottomNavigationBar(
            items: bottomNavItems,
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Hello World",
                style: TextStyle(
                  fontFamily: "SB AggroOTF",
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: HelloColors.mainColor2,
                ),
              ),
              InkWell(
                onTap: () {
                  context.push('/mypage-menu');
                },
                child: Container(
                  width: 44,
                  height: 44,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: SvgPicture.asset(
                      "assets/images/home/profile_icon.svg",
                      width: 20,
                      height: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Text(
            context.tr("app_name"),
            style: const TextStyle(
              fontFamily: "SB AggroOTF",
              fontSize: 14,
              fontWeight: FontWeight.w200,
              color: HelloColors.subTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
