// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomDto _$RoomDtoFromJson(Map<String, dynamic> json) => RoomDto(
      roomId: json['roomId'] as String,
      chatLogs: (json['chatLogs'] as List<dynamic>)
          .map((e) => ChatLogDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RoomDtoToJson(RoomDto instance) => <String, dynamic>{
      'roomId': instance.roomId,
      'chatLogs': instance.chatLogs,
    };
