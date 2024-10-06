import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_world_mvp/home/application/home_bloc.dart';
import 'package:hello_world_mvp/injection.dart';
import 'package:hello_world_mvp/locale/application/locale_bloc.dart';
import 'package:hello_world_mvp/route/application/route_bloc.dart'; // 추가된 import

import '../../locale/domain/localization_service.dart';
import '../../route/domain/navigation_service.dart';
import 'widgets/home_page_content.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final LocalizationService _localizationService;

  List<String> _imagesPath() {
    return [
      'assets/images/home_chat.png',
      'assets/images/home_callbot.png',
      'assets/images/home_resume.png',
      'assets/images/home_job.png',
    ];
  }

  @override
  Widget build(BuildContext context) {
    final _navigationService = NavigationService(context);
    final _localizationService = LocalizationService();

    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (context) => getIt<HomeBloc>()..add(GetToken()),
        ),
        BlocProvider<LocaleBloc>(
          create: (context) => getIt<LocaleBloc>(), // LocaleBloc 추가
        ),
        BlocProvider<RouteBloc>(
          create: (context) => getIt<RouteBloc>(), // RouteBloc 추가
        ),
      ],
      child: Builder(
        builder: (context) {
          return BlocListener<HomeBloc, HomeState>(
            listenWhen: (prev, cur) {
              return prev.needSignIn != cur.needSignIn;
            },
            listener: (context, state) {
              if ((state.needSignIn ?? false) == true) {
                context.push("/login");
              }
            },
            child: HomePageContent(
              localizationService: _localizationService,
              imagesPath: _imagesPath(),
              navigationService: _navigationService,
            ),
          );
        },
      ),
    );
  }
}
