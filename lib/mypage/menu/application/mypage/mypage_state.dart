// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'mypage_bloc.dart';

class MypageState extends Equatable {
  final MyInfo? myInfo;
  final MypageFailure? failure;
  final bool isLoading;

  const MypageState({
    required this.myInfo,
    required this.failure,
    required this.isLoading,
  });

  factory MypageState.initial() =>
      const MypageState(myInfo: null, failure: null, isLoading: false);

  @override
  List<Object?> get props => [myInfo, failure, isLoading];

  MypageState copyWith({
    MyInfo? myInfo,
    MypageFailure? failure,
    bool? isLoading,
  }) {
    return MypageState(
      myInfo: myInfo ?? this.myInfo,
      failure: failure ?? this.failure,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
