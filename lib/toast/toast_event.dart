part of 'toast_bloc.dart';

sealed class ToastEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class Show extends ToastEvent {
  final String message;

  Show({required this.message});

  @override
  List<Object> get props => [message];
}

final class InsertQueue extends ToastEvent {
  final String message;

  InsertQueue({required this.message});

  @override
  List<Object> get props => [message];
}

final class Reset extends ToastEvent {}
