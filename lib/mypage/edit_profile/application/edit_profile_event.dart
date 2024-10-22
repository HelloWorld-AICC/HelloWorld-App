part of 'edit_profile_bloc.dart';

sealed class EditProfileEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class GetMyInfo extends EditProfileEvent {
  GetMyInfo();

  @override
  List<Object> get props => [];
}
