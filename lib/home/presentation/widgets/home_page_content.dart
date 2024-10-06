import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../custom_bottom_navigationbar.dart';
import '../../../locale/application/locale_bloc.dart';
import '../../../locale/domain/localization_service.dart';
import '../../../route/domain/navigation_service.dart';
import 'home_route_grid.dart';

class HomePageContent extends StatelessWidget {
  final LocalizationService localizationService;
  final List<String> imagesPath;
  final NavigationService navigationService;

  final Map<String, IconData> bottomNavItems = {
    'bottom_navigation.chat': Icons.chat,
    'bottom_navigation.resume': Icons.file_copy,
    'bottom_navigation.home': Icons.home,
    'bottom_navigation.call_bot': Icons.phone,
    'bottom_navigation.consultation_center': Icons.support_agent,
  };

  HomePageContent({
    Key? key,
    required this.localizationService,
    required this.imagesPath,
    required this.navigationService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleBloc, LocaleState>(
      builder: (context, state) {
        final paddingVal = MediaQuery.of(context).size.height * 0.1;

        return Scaffold(
          body: Container(
            padding: EdgeInsets.only(top: paddingVal / 2),
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
              padding: EdgeInsets.all(paddingVal / 3),
              child: Column(
                children: [
                  _buildHeader(context),
                  _buildImageSection(),
                  HomeRouteGrid(
                    images: imagesPath,
                    items: localizationService.getTranslatedTexts([
                      'home_grid.chat',
                      'home_grid.call_bot',
                      'home_grid.resume',
                      'home_grid.job',
                    ]),
                    navigationService: navigationService,
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
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${tr("app_name")},",
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF10498E),
            ),
          ),
          const Text(
            "HelloWorld",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color(0xFF002E4F),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageSection() {
    return Stack(
      children: [
        Container(
          alignment: Alignment.centerRight,
          margin: EdgeInsets.only(bottom: 8),
          child: SizedBox(
            width: 250.0,
            height: 300.0,
            child: Image.asset(
              'assets/images/home/Nice to meet you.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }
}
