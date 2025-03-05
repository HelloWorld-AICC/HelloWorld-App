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
            color: Color(0xffEEF6FF),
            // decoration: const BoxDecoration(
            //   gradient: LinearGradient(
            //     colors: [
            //       Color(0xFFD1E6FF),
            //       Color(0xFFDDEDFF),
            //       Color(0xFFFFFFFF),
            //     ],
            //     begin: Alignment.topCenter,
            //     end: Alignment.bottomCenter,
            //   ),
            // ),
            child: Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.sizeOf(context).width * 0.05,
                  right: MediaQuery.sizeOf(context).width * 0.05,
                  top: MediaQuery.sizeOf(context).height * 0.05),
              child: Stack(
                children: [
                  Positioned(
                    top: 50,
                    left: MediaQuery.sizeOf(context).width * 0.1,
                    child: _buildHeader(context),
                  ),
                  Positioned(
                    top: MediaQuery.sizeOf(context).height * 0.3,
                    child: HomeRouteGrid(
                      items: routeBoxItems,
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.sizeOf(context).height * 0.3 - 10,
                    child: Container(
                      height: MediaQuery.of(context).size.height / 10,
                      width: MediaQuery.of(context).size.width -
                          MediaQuery.sizeOf(context).width * 0.05 * 2,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xffE2E2E2),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        color: HelloColors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 90,
                    right: 30,
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/home/mascot.png',
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width / 3.8,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: InkWell(
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
                  )
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            child: CustomBottomNavigationBar(
              items: bottomNavItems,
              backgroundColor: Color(0xffEEF6FF),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Hello World",
            style: TextStyle(
              fontFamily: "SB AggroOTF",
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: Color(0xff5E8DC5),
            ),
          ),
          SizedBox(height: 4),
          Text(
            context.tr("app_name"),
            style: const TextStyle(
              fontFamily: "SB AggroOTF",
              fontSize: 10,
              fontWeight: FontWeight.w100,
              color: HelloColors.subTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
