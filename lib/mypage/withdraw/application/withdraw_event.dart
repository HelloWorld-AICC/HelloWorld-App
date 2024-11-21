part of 'withdraw_bloc.dart';

sealed class WithdrawEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class Confirmed extends WithdrawEvent {
  Confirmed();

  @override
  List<Object> get props => [];
}
