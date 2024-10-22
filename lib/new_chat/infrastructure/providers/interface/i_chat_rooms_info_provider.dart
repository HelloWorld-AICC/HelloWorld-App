import 'package:dartz/dartz.dart';

import '../../../domain/failure/chat_failure.dart';
import '../../../domain/model/chat_room_info.dart';
import '../../dtos/room_info_dto.dart';

abstract class IChatRoomsInfoProvider {
  Either<ChatRoomsInfoFetchFailure, List<ChatRoomInfo>> setChatRoomsInfo(
      List<RoomInfoDto> chatRoomsInfo);
}
