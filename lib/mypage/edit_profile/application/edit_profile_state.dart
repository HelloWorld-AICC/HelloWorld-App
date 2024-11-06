// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'edit_profile_bloc.dart';

class EditProfileState extends Equatable {
  final MyInfo? myInfo;
  final MypageFailure? failure;
  final bool isLoading;
  final String? newNickname;

  const EditProfileState({
    required this.myInfo,
    required this.failure,
    required this.isLoading,
    required this.newNickname,
  });

  factory EditProfileState.initial() => const EditProfileState(
      myInfo: null, failure: null, isLoading: false, newNickname: null);

  @override
  List<Object?> get props => [myInfo, failure, isLoading, newNickname];

  EditProfileState copyWith({
    MyInfo? myInfo,
    MypageFailure? failure,
    bool? isLoading,
    String? newNickname,
  }) {
    return EditProfileState(
      myInfo: myInfo ?? this.myInfo,
      failure: failure ?? this.failure,
      isLoading: isLoading ?? this.isLoading,
      newNickname: newNickname ?? this.newNickname,
    );
  }
}
