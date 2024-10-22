part of 'mypage_bloc.dart';

sealed class MypageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class GetMyInfo extends MypageEvent {
  GetMyInfo();

  @override
  List<Object> get props => [];
}
