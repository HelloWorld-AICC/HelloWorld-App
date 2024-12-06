part of 'center_bloc.dart';

class CenterState extends Equatable {
  final List<Center> centers;
  final CenterFailure? failure;

  const CenterState({this.centers = const [], required this.failure});

  @override
  List<Object> get props => [centers];

  factory CenterState.initial() => CenterState(failure: null);

  CenterState copyWith({List<Center>? centers, CenterFailure? failure}) {
    return CenterState(centers: centers ?? this.centers, failure: failure);
  }
}
