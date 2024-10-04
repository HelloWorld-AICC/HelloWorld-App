part of 'app_lifecycle_bloc.dart';

sealed class CustomAppLifecycleEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class CustomAppPaused extends CustomAppLifecycleEvent {}

final class CustomAppResumed extends CustomAppLifecycleEvent {}
