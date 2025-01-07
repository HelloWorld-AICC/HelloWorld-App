part of 'app_init_bloc.dart';

sealed class AppInitEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class MarkAppRunnedBefore extends AppInitEvent {}

final class MarkSplashDone extends AppInitEvent {}

final class MarkLanguageSelected extends AppInitEvent {}
