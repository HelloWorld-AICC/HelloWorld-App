part of 'tab_navigation_bloc.dart';

sealed class TabNavigationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class TabChanged extends TabNavigationEvent {
  final int newIndex;
  final String? roomId;

  TabChanged({required this.newIndex, this.roomId});

  @override
  List<Object?> get props => [newIndex, roomId];
}
