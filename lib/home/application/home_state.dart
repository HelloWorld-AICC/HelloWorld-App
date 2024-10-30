// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

class HomeState extends Equatable {
  final bool? needSignIn;

  const HomeState({required this.needSignIn});

  factory HomeState.initial() => const HomeState(
        needSignIn: null,
      );

  @override
  List<Object?> get props => [needSignIn];

  HomeState copyWith({
    bool? needSignIn,
  }) {
    return HomeState(
      needSignIn: needSignIn ?? this.needSignIn,
    );
  }
}
