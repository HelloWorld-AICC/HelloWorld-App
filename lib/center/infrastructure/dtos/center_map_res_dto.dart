import 'package:hello_world_mvp/center/domain/model/center.dart';

import '../../../core/value_objects.dart';

class CenterMapResDto {
  String name;
  CenterStatus centerStatus;
  String closed;
  String address;
  String image;
  double latitude;
  double longitude;

  CenterMapResDto(
      {required this.name,
      required this.centerStatus,
      required this.closed,
      required this.address,
      required this.image,
      required this.latitude,
      required this.longitude});

  factory CenterMapResDto.fromJson(Map<String, dynamic> json) {
    return CenterMapResDto(
      name: json['name'],
      centerStatus: CenterStatus.values[json['centerStatus']],
      closed: json['closed'],
      address: json['address'],
      image: json['image'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'centerStatus': centerStatus.index,
      'closed': closed,
      'address': address,
      'image': image,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  Center toDomain() {
    return Center(
      name: StringVO(name),
      status: centerStatus,
      closed: StringVO(closed),
      address: StringVO(address),
      image: StringVO(image),
      latitude: DoubleVO(latitude),
      longitude: DoubleVO(longitude),
    );
  }
}
