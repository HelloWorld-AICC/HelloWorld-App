import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../design_system/hello_colors.dart';
import '../../application/session/chat_session_bloc.dart';

class ChatAppbar extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppbar({
    super.key,
    required GlobalKey<ScaffoldState> scaffoldKey,
  }) : _scaffoldKey = scaffoldKey;

  final GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          context.tr('chat_title'),
          style: TextStyle(
            color: HelloColors.subTextColor,
            fontFamily: "SB AggroOTF",
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      leading: IconButton(
        icon: Icon(
          Icons.list_rounded,
          color: HelloColors.subTextColor,
        ),
        color: HelloColors.subTextColor,
        onPressed: () {
          _scaffoldKey.currentState?.openDrawer();
        },
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.add,
            color: HelloColors.subTextColor,
          ),
          onPressed: () {
            context.read<ChatSessionBloc>().add(ClearChatSessionEvent());
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
