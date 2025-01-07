part of 'route_bloc.dart';

sealed class RouteEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class RouteChanged extends RouteEvent {
  final int newIndex;
  final String newRoute;

  RouteChanged({required this.newIndex, required this.newRoute});

  @override
  List<Object?> get props => [newIndex, newRoute];
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
