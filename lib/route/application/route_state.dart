part of 'route_bloc.dart';

class RouteState {
  final int currentIndex;
  final String currentRoute;

  const RouteState({
    required this.currentIndex,
    required this.currentRoute,
  });

  factory RouteState.initial() {
    return RouteState(
      currentIndex: 2,
      currentRoute: '/',
    );
  }
  
  List<Object?> get props => [currentIndex, currentRoute];

  RouteState copyWith({int? currentIndex, String? currentRoute}) {
    return RouteState(
      currentIndex: currentIndex ?? this.currentIndex,
      currentRoute: currentRoute ?? this.currentRoute,
    );
  }
}
