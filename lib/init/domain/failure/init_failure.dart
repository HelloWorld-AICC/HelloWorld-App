import 'package:hello_world_mvp/fetch/failure.dart';

class InitFailure extends Failure {
  InitFailure({required super.message});

  @override
  List<Object> get props => [message];
}

class InitSendUserLanguageFailure extends InitFailure {
  InitSendUserLanguageFailure() : super(message: "선택한 언어를 서버에 전송하는데 실패했습니다.");
}

class InitGetUserLanguageFailure extends InitFailure {
  InitGetUserLanguageFailure() : super(message: "사용자 언어를 가져오는데 실패했습니다.");
}

class InitSyncUserLanguageFailure extends InitFailure {
  InitSyncUserLanguageFailure() : super(message: "사용자 언어를 동기화하는데 실패했습니다.");
}
