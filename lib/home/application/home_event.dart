part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class GetToken extends HomeEvent {
  GetToken();

  @override
  List<Object> get props => [];
}
