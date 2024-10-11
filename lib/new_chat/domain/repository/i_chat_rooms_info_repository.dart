import 'package:dartz/dartz.dart';

import '../failure/chat_failure.dart';
import '../model/chat_room_info.dart';

abstract class IChatRoomsInfoRepository {
  Future<Either<ChatRoomsInfoFetchFailure, List<ChatRoomInfo>>>
      getChatRoomsInfo();
}
