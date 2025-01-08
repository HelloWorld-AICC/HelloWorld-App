import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../design_system/hello_colors.dart';
import '../route/application/route_bloc.dart';

class CallBotScreen extends StatelessWidget {
  const CallBotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (result) {
        if (result) {
          print("Pop invoked in call bot");
          context.read<RouteBloc>().add(PopEvent());
        }
      },
      child: Scaffold(
        backgroundColor: HelloColors.white,
        body: Center(
          child: LoadingAnimationWidget.staggeredDotsWave(
              color: HelloColors.mainColor1, size: 50),
        ),
      ),
    );
  }
}
