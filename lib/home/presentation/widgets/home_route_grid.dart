import 'package:flutter/material.dart';
import 'package:hello_world_mvp/design_system/hello_colors.dart';
import 'package:hello_world_mvp/route/domain/service/route_service.dart';

import 'home_route_item.dart';

class HomeRouteGrid extends StatelessWidget {
  final Map<String, Map<String, Object>> items;

  HomeRouteGrid({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 1.15,
            height: MediaQuery.of(context).size.height / 10,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(
                color: HelloColors.mainBlue,
                width: 1.0,
              ),
              color: HelloColors.white,
            ),
          ),
          const SizedBox(height: 12), // 간격 추가
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildGridItem(
                context,
                items['center']!,
                "/center",
                MediaQuery.of(context).size.height / 6,
                130,
                130,
                Alignment.bottomCenter,
              ),
              const SizedBox(width: 3), // 간격 추가
              _buildGridItem(
                context,
                items['community']!,
                "/community",
                MediaQuery.of(context).size.height / 6,
                130,
                130,
                Alignment.center,
              ),
            ],
          ),
          const SizedBox(height: 3), // 간격 추가
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Stack(
                    children: [
                      _buildGridItem(
                        context,
                        items['resume']!,
                        "/resume",
                        MediaQuery.of(context).size.height / 5,
                        150,
                        150,
                        Alignment.bottomRight,
                      ),
                      Positioned(
                        right: 8, // Adjust as needed
                        bottom: 8, // Adjust as needed
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: HelloColors.mainBlue,
                            // Background color of the badge
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            "Beta",
                            style: TextStyle(
                              color: HelloColors.subTextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // const SizedBox(height: 3), // 간격 추가
                  // _buildGridItem(
                  //   context,
                  //   items['callbot']!,
                  //   "/callbot",
                  //   MediaQuery.of(context).size.height / 7.5,
                  //   150,
                  //   150,
                  //   Alignment.bottomCenter,
                  // ),
                ],
              ),
              const SizedBox(width: 3), // 간격 추가
              _buildGridItem(
                context,
                items['chat']!,
                "/chat",
                MediaQuery.of(context).size.height / 5,
                500,
                500,
                Alignment.center,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGridItem(
      BuildContext context,
      Map<String, Object> item,
      String routePath,
      double height,
      double imgWidth,
      double imgHeight,
      Alignment imgAlign) {
    return Padding(
      padding: const EdgeInsets.all(3.0), // 패딩을 3으로 설정
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 2.35,
        height: height,
        child: HomeRouteItem(
          title: item['title'] as String,
          subTitle: item['subTitle'] as String,
          imgPath: item['imgPath'] as String,
          bottomIndex: item['bottom_index'] as int,
          routePath: routePath,
          imgWidth: imgWidth,
          imgHeight: imgHeight,
          isBeta: item['isBeta'] as bool,
          imgAlign: imgAlign,
        ),
      ),
    );
  }
}
