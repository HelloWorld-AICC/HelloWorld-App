part of 'tab_navigation_bloc.dart';

class TabNavigationState extends Equatable {
  final int currentIndex;

  const TabNavigationState({required this.currentIndex});

  factory TabNavigationState.initial() =>
      const TabNavigationState(currentIndex: 0);

  @override
  List<Object?> get props => [currentIndex];

  TabNavigationState copyWith({int? currentIndex}) {
    return TabNavigationState(
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}
