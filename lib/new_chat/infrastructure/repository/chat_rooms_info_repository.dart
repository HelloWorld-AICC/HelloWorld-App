import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../fetch/fetch_service.dart';
import '../../domain/failure/chat_failure.dart';
import '../../domain/model/chat_room_info.dart';
import '../../domain/repository/i_chat_rooms_info_repository.dart';
import '../../domain/service/chat_fetch_service.dart';
import '../dtos/room_info_dto.dart';
import '../providers/chat_rooms_info_provider.dart';

@injectable
@LazySingleton(as: IChatRoomsInfoRepository)
class ChatRoomsInfoRepository implements IChatRoomsInfoRepository {
  final ChatFetchService _fetchService;
  final ChatRoomsInfoProvider _chatRoomsInfoProvider;

  ChatRoomsInfoRepository(this._fetchService, this._chatRoomsInfoProvider);

  @override
  Future<Either<ChatRoomsInfoFetchFailure, List<ChatRoomInfo>>>
      getChatRoomsInfo() async {
    final failureOrResponse = await _fetchService.request(
        method: HttpMethod.get,
        pathPrefix: '/webflux',
        path: '/user/room-list');
    return failureOrResponse.fold(
      (f) => left(
          ChatRoomsInfoFetchFailure(message: "Failed to fetch rooms info")),
      (response) {
        final chatRoomsInfo = (response.result as List).map((e) {
          final roomInfoDto = RoomInfoDto.fromJson(e as Map<String, dynamic>);
          return roomInfoDto;
        }).toList();

        final eitherResult =
            _chatRoomsInfoProvider.setChatRoomsInfo(chatRoomsInfo);

        return eitherResult.fold(
          (failure) => left(failure),
          (chatRoomInfoList) => right(chatRoomInfoList),
        );
      },
    );
  }
}
