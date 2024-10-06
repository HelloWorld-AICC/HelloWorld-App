part of 'route_bloc.dart';

class RouteState extends Equatable {
  final int currentIndex;
  final String currentRoute;

  const RouteState({
    required this.currentIndex,
    required this.currentRoute,
  });

  factory RouteState.initial() {
    return RouteState(
      currentIndex: 0,
      currentRoute: '/',
    );
  }

  @override
  List<Object?> get props => [currentIndex];

  RouteState copyWith({int? currentIndex, String? currentRoute}) {
    return RouteState(
      currentIndex: currentIndex ?? this.currentIndex,
      currentRoute: currentRoute ?? this.currentRoute,
    );
  }
}
