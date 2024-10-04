import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world_mvp/new_chat/domain/service/chat/chat_service.dart';
import 'package:hello_world_mvp/new_chat/presentation/widgets/chat_tab.dart';
import 'package:hello_world_mvp/new_chat/presentation/widgets/messages_list.dart';

import '../../injection.dart';
import '../application/app/lifecycle/app_lifecycle_bloc.dart';
import '../application/app/init/app_init_bloc.dart';
import '../application/app/navigation/tab_navigation_bloc.dart';
import '../application/chat/session/chat_session_bloc.dart';

class NewChatPage extends StatelessWidget {
  final _chatService = ChatService();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CustomAppLifecycleBloc>(
          create: (context) => getIt<CustomAppLifecycleBloc>(),
        ),
        BlocProvider<AppInitBloc>(
          create: (context) => getIt<AppInitBloc>(),
        ),
        BlocProvider<TabNavigationBloc>(
          create: (context) => getIt<TabNavigationBloc>(),
        ),
        BlocProvider<ChatSessionBloc>(
          create: (context) => getIt<ChatSessionBloc>(),
        ),
      ],
      child: Scaffold(
        body: _NewChatPageContent(),
        bottomNavigationBar: CustomBottomNavigationBar(),
      ),
    );
  }
}

class _NewChatPageContent extends StatefulWidget {
  @override
  _NewChatPageContentState createState() => _NewChatPageContentState();
}

class _NewChatPageContentState extends State<_NewChatPageContent>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    context.read<CustomAppLifecycleBloc>().add(CustomAppResumed());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      context.read<CustomAppLifecycleBloc>().add(CustomAppResumed());
    } else if (state == AppLifecycleState.paused) {
      context.read<CustomAppLifecycleBloc>().add(CustomAppPaused());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AppInitBloc, AppInitState>(
        builder: (context, initState) => initState.isFirstRun
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(child: MessageListWidget()),
                  if (_isTyping) _buildTypingIndicator(),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: _buildActionButtons(),
                    ),
                  ),
                  _buildInputArea(),
                ],
              )
            : _buildContent(),
      ),
    );
  }

  Widget _buildContent() => Column(
        children: [
          Expanded(
            child: BlocBuilder<TabNavigationBloc, TabNavigationState>(
              builder: (context, tabState) =>
                  _buildCurrentTab(tabState.currentIndex),
            ),
          ),
          CustomBottomNavigationBar(),
        ],
      );

  Widget _buildCurrentTab(int index) => index == 1
      ? BlocBuilder<ChatSessionBloc, ChatSessionState>(
          builder: (context, chatState) {
            if (chatState.isLoading) return CircularProgressIndicator();
            if (chatState.failure != null)
              return Text('Error: ${chatState.failure}');
            return ChatTab();
          },
        )
      : index == 0
          ? Center(child: Text("홈 화면"))
          : Center(child: Text("프로필 화면"));
}

class CustomBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabNavigationBloc, TabNavigationState>(
      builder: (context, tabState) {
        return BottomNavigationBar(
          currentIndex: tabState.currentIndex,
          onTap: (index) => context
              .read<TabNavigationBloc>()
              .add(TabChanged(newIndex: index)),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        );
      },
    );
  }
}
