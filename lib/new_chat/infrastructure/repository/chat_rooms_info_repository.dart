import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../fetch/fetch_service.dart';
import '../../domain/failure/chat_failure.dart';
import '../../domain/model/chat_room_info.dart';
import '../../domain/repository/i_chat_rooms_info_repository.dart';
import '../../domain/service/chat_fetch_service.dart';
import '../../presentation/widgets/new_chat_content.dart';
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
        final chatRoomsInfo = (response.result['result'] as List).map((e) {
          final Map<String, dynamic> eMap = e as Map<String, dynamic>;

          final parsedRoomId = eMap['roomId'] as String;
          var parsedContent = eMap['title'] as String;

          if (eMap.containsKey('title') && eMap['title'] is String) {
            var titleJsonString = eMap['title'] as String;

            final jsonFixPattern =
                RegExp(r'(?<=[{,])(\w+):'); // 속성 이름 앞에 따옴표 추가
            titleJsonString =
                titleJsonString.replaceAllMapped(jsonFixPattern, (match) {
              return '"${match[1]}":';
            });

            if (!titleJsonString.endsWith('"')) {
              titleJsonString += '"';
            }
            if (!titleJsonString.endsWith('}')) {
              titleJsonString += '}';
            }

            try {
              final Map<String, dynamic> titleMap = jsonDecode(titleJsonString);
              final content = titleMap['content'];
              parsedContent = content;
              print('Parsed Content: $content');
            } catch (error) {
              print('Error parsing title JSON: $error');
            }
          }

          print('Parsed are $parsedRoomId, $parsedContent');
          return RoomInfoDto(
            roomId: parsedRoomId,
            title: parsedContent,
          );
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
