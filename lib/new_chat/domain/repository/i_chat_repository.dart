import 'package:dartz/dartz.dart';

import '../../../core/value_objects.dart';
import '../failure/chat_failure.dart';
import '../model/chat_room.dart';
import '../model/chat_room_info.dart';

abstract class IChatRepository {
  Future<Either<ChatFailure, ChatRoom>> getRoomById(StringVO roomId);

  Future<Either<ChatFailure, List<ChatRoomInfo>>> fetchRoomsInfo();

  Future<Either<ChatFailure, Unit>> sendMessage(
      StringVO roomId, StringVO message);
}
