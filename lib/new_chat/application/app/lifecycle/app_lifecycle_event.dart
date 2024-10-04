part of 'app_lifecycle_bloc.dart';

sealed class AppLifecycleEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class AppPaused extends AppLifecycleEvent {}

final class AppResumed extends AppLifecycleEvent {}
