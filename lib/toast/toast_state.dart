// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'toast_bloc.dart';

class ToastState extends Equatable {
  final String? message;
  final DateTime updatedAt;
  final bool isShowing;

  const ToastState({
    required this.message,
    required this.updatedAt,
    required this.isShowing,
  });

  factory ToastState.initial() => ToastState(
        message: null,
        updatedAt: DateTime.now(),
        isShowing: false,
      );

  ToastState copyWith({
    String? message,
    DateTime? updatedAt,
    bool? isShowing,
  }) {
    return ToastState(
      message: message ?? this.message,
      updatedAt: updatedAt ?? this.updatedAt,
      isShowing: isShowing ?? this.isShowing,
    );
  }

  @override
  List<Object?> get props => [message, updatedAt, isShowing];
}
