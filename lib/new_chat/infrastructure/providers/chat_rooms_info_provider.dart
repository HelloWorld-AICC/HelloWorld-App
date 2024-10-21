import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../domain/failure/chat_failure.dart';
import '../../domain/model/chat_room_info.dart';
import '../dtos/room_info_dto.dart';
import 'interface/i_chat_rooms_info_provider.dart';

@injectable
@LazySingleton(as: IChatRoomsInfoProvider)
class ChatRoomsInfoProvider implements IChatRoomsInfoProvider {
  List<RoomInfoDto> _chatRoomsInfo = [];

  List<RoomInfoDto> get chatRoomsInfo => _chatRoomsInfo;

  Either<ChatRoomsInfoFetchFailure, List<ChatRoomInfo>> setChatRoomsInfo(
      List<RoomInfoDto> chatRoomsInfo) {
    try {
      _chatRoomsInfo = chatRoomsInfo;
      final chatRoomInfoList =
          _chatRoomsInfo.map((dto) => dto.toDomain()).toList();

      return right(chatRoomInfoList);
    } catch (error) {
      return left(ChatRoomsInfoFetchFailure(
        message: "Failed to set chat rooms info",
      ));
    }
  }
}
