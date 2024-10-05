import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world_mvp/new_chat/presentation/common/typing_indicator.dart';
import 'package:hello_world_mvp/new_chat/presentation/widgets/messages_list.dart';

import '../../core/value_objects.dart';
import '../../injection.dart';
import '../application/app/lifecycle/app_lifecycle_bloc.dart';
import '../application/app/init/app_init_bloc.dart';
import '../application/app/navigation/tab_navigation_bloc.dart';
import '../application/chat/session/chat_session_bloc.dart';
import '../application/chat/typing_state.dart';
import '../domain/model/chat_log.dart';
import 'common/chat_input_field.dart';
import 'common/custom_bottom_navigation_bar.dart';
import 'widgets/action_buttons.dart';

class NewChatPage extends StatelessWidget {
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
  final TextEditingController _controller = TextEditingController();

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
          builder: (context, initState) => true //initState.isFirstRun
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(child: MessageListWidget()),
                    if (context.watch<ChatSessionBloc>().state.typingState ==
                        TypingState.typing)
                      TypingIndicator(),
                    BlocBuilder<CustomAppLifecycleBloc,
                        CustomAppLifecycleState>(
                      builder: (context, state) {
                        if (state.isResumed) {
                          return Expanded(
                            child: ActionButtonsWidget(
                              onButtonPressed: (selectedContent) {
                                context
                                    .read<CustomAppLifecycleBloc>()
                                    .add(CustomAppPaused());

                                // context.read<ChatSessionBloc>().add(SendMessageEvent(
                                //   message: ChatLog(
                                //     content: StringVO(selectedContent),
                                //     sender: StringVO('user'),
                                //   ),
                                //   roomId: '',
                                // ));
                              },
                            ),
                          );
                        } else {
                          return SizedBox.shrink();
                        }
                      },
                    ),
                    _buildInputArea(),
                  ],
                )
              : Text("") // _buildContent(),
          ),
    );
  }

  Widget _buildInputArea() {
    return ChatInputField(
      controller: _controller,
      onSend: (message) {
        context.read<ChatSessionBloc>().add(SendMessageEvent(
              message:
                  ChatLog(content: StringVO(message), sender: StringVO('user')),
              roomId: '',
            ));
      },
    );
  }
}
