part of 'route_bloc.dart';

sealed class RouteEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class RouteChanged extends RouteEvent {
  final int newIndex;

  RouteChanged({required this.newIndex});

  @override
  List<Object?> get props => [newIndex];
}

final class RouteEventHome extends RouteEvent {
  RouteEventHome();

  @override
  List<Object?> get props => [];
}

final class RouteEventLogin extends RouteEvent {
  RouteEventLogin();

  @override
  List<Object?> get props => [];
}

final class RouteEventSplash extends RouteEvent {
  RouteEventSplash();

  @override
  List<Object?> get props => [];
}

final class PopEvent extends RouteEvent {
  PopEvent();

  @override
  List<Object?> get props => [];
}

// final class ChatSelected extends RouteEvent {
//   final String? roomId;
//
//   ChatSelected({this.roomId});
//
//   @override
//   List<Object?> get props => [roomId];
// }
