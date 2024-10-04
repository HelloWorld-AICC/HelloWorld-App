part of 'app_init_bloc.dart';

sealed class AppInitEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class CheckAppFirstRun extends AppInitEvent {}
