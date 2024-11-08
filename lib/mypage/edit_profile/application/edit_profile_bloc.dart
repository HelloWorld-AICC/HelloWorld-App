import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hello_world_mvp/mypage/menu/domain/failure/mypage_failure.dart';
import 'package:hello_world_mvp/mypage/menu/domain/model/my_info.dart';
import 'package:hello_world_mvp/mypage/menu/domain/repository/i_mypage_repository.dart';
import 'package:image_picker/image_picker.dart';

import 'package:injectable/injectable.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

@injectable
class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final IMypageRepository myPageRepository;

  EditProfileBloc({required this.myPageRepository})
      : super(EditProfileState.initial()) {
    on<GetMyInfo>((event, emit) async {
      emit(EditProfileState.initial().copyWith(isLoading: true));
      final tokenOrFailure = await myPageRepository.getMyInfo();

      emit(tokenOrFailure.fold((f) {
        return state.copyWith(failure: f, isLoading: false);
      }, (myInfo) {
        return state.copyWith(myInfo: myInfo, isLoading: false);
      }));
    });

    on<NicknameChanged>((event, emit) {
      emit(state.copyWith(
        newNickname: event.nickname,
      ));
    });

    on<SelectImage>((event, emit) async {
      final ImagePicker picker = ImagePicker();
      // Pick an image.
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      emit(state.copyWith(selectedProfileImage: image));
    });

    on<Submit>((event, emit) async {
      
    });
  }
}
