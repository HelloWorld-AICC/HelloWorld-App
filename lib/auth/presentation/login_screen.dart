import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world_mvp/auth/application/login_bloc.dart';
import 'package:hello_world_mvp/injection.dart';
import 'package:hello_world_mvp/toast/common_toast.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LoginBloc>(),
      child: Builder(builder: (context) {
        return MultiBlocListener(
          listeners: [
            BlocListener<LoginBloc, LoginState>(
              listenWhen: (prev, cur) =>
                  (prev.succeeded != cur.succeeded) && (cur.succeeded == true),
              listener: (context, state) {
                Navigator.of(context).pop();
                showToast("로그인에 성공했습니다.");
              },
            ),
            BlocListener<LoginBloc, LoginState>(
              listenWhen: (prev, cur) => prev.failure != cur.failure,
              listener: (context, state) {
                showToast(state.failure?.message ?? "알 수 없는 오류가 발생했습니다.");
              },
            ),
          ],
          child: Stack(
            children: [
              SafeArea(
                child: Scaffold(
                    backgroundColor: Colors.white,
                    body: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // const SizedBox(height: 70),
                        const _Title(),
                        const SizedBox(height: 20),
                        Image.asset(
                          "assets/images/auth/login_main.png",
                          width: double.infinity,
                          fit: BoxFit.fitWidth,
                        ),
                        const SizedBox(height: 4),
                        const _LoginButtonArea()
                      ],
                    )),
              ),
              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  return state.isLoading
                      ? const Positioned.fill(
                          child: Center(child: CircularProgressIndicator()))
                      : const SizedBox();
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}

class _LoginButtonArea extends StatelessWidget {
  const _LoginButtonArea();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          margin: const EdgeInsets.all(24),
          padding: const EdgeInsets.all(16),
          child: const Center(child: _LoginWithGoogle())),
    );
  }
}

class _LoginWithGoogle extends StatelessWidget {
  const _LoginWithGoogle();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<LoginBloc>().add(SignInWithGoogle());
      },
      child: Container(
          height: 35,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                width: 1,
                color: const Color(0xFFEBEBEB),
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/auth/google_logo.png"),
              const SizedBox(width: 8),
              const Text("Google로 로그인",
                  style: TextStyle(
                    color: Color(0xFF0F0F0F),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    height: 20 / 12,
                    letterSpacing: 0.1,
                  ))
            ],
          )),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 24,
      ),
      child: Text("외국인 지원센터 AICC\nHello World",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w700,
            height: 1.0,
          )),
    );
  }
}
