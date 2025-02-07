import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_world_mvp/home/application/home_bloc.dart';
import 'package:hello_world_mvp/injection.dart';
import 'package:hello_world_mvp/locale/application/locale_bloc.dart';
import 'package:hello_world_mvp/resume/new_resume_screen.dart';
import 'package:hello_world_mvp/route/application/route_bloc.dart'; // 추가된 import

import '../../center/presentation/center_screen.dart';
import '../../community/board/presentation/community_board.dart';
import '../../locale/domain/localization_service.dart';
import '../../new_chat/presentation/new_chat_page.dart';
import '../../resume/prev/resume_screen.dart';
import '../../route/domain/route_service.dart';
import 'widgets/home_page_content.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (context) => getIt<HomeBloc>()..add(GetToken()),
        ),
        BlocProvider<LocaleBloc>(
          create: (context) => getIt<LocaleBloc>(), // LocaleBloc 추가
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
                context.replace("/login");
              }
            },
            child: BlocBuilder<RouteBloc, RouteState>(
              builder: (context, state) {
                return [
                  NewChatPage(),
                  ResumeScreen(),
                  HomePageContent(
                    imagesPath: _imagesPath(),
                  ),
                  const CommunityBoard(),
                  CenterScreen()
                ][state.currentIndex];
              },
            ),
          );
        },
      ),
    );
  }
}
