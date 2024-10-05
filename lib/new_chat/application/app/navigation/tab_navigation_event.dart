part of 'tab_navigation_bloc.dart';

sealed class TabNavigationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class TabChanged extends TabNavigationEvent {
  final int newIndex;

  TabChanged({required this.newIndex});

  @override
  List<Object?> get props => [newIndex];
}

final class ChatTabSelected extends TabNavigationEvent {
  final String? roomId;

  ChatTabSelected({this.roomId});

  @override
  List<Object?> get props => [roomId];
}
