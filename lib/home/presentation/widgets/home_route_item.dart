import 'package:flutter/material.dart';

import '../../../route/domain/navigation_service.dart';

class HomeRouteItem extends StatelessWidget {
  final int index;
  final String assetName;
  final String itemName;
  final String path;
  final NavigationService navigationService;

  HomeRouteItem({
    Key? key,
    required this.index,
    required this.assetName,
    required this.itemName,
    required this.path,
    required this.navigationService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigationService.navigateTo(path);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(
            color: const Color(0xFF6D9CD5).withOpacity(0.3),
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
        child: Padding(
          padding: EdgeInsets.all(3.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                alignment: Alignment.topRight,
                child: Container(
                  width: 60,
                  height: 60,
                  child: Align(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Image.asset(
                        assetName,
                        width: 100.0,
                        height: 100.0,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                child: Text(
                  itemName,
                  style: const TextStyle(
                    color: Color(0xFF6D9CD5),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 2.0),
                child: Text(
                  itemName,
                  style: const TextStyle(
                    color: Color(0xFF6D9CD5),
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
