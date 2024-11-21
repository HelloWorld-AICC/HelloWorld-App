// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'withdraw_bloc.dart';

class WithdrawState extends Equatable {
  final bool? isWithdrawn;
  final AuthFailure? failure;
  final bool isLoading;

  const WithdrawState({
    required this.isWithdrawn,
    required this.failure,
    required this.isLoading,
  });

  factory WithdrawState.initial() =>
      const WithdrawState(isWithdrawn: null, failure: null, isLoading: false);

  @override
  List<Object?> get props => [isWithdrawn, failure, isLoading];

  WithdrawState copyWith({
    bool? iswithdrawn,
    AuthFailure? failure,
    bool? isLoading,
  }) {
    return WithdrawState(
      isWithdrawn: iswithdrawn ?? this.isWithdrawn,
      failure: failure ?? this.failure,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
