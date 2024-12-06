import '../../../core/value_objects.dart';

class Center {
  final IntVO id;
  final StringVO name;
  final StringVO status;
  final StringVO closed;
  final StringVO address;
  final StringVO image;
  final DoubleVO latitude;
  final DoubleVO longitude;

  Center({
    required this.id,
    required this.name,
    required this.status,
    required this.closed,
    required this.address,
    required this.image,
    required this.latitude,
    required this.longitude,
  });

  factory Center.fromJson(Map<String, dynamic> json) {
    return Center(
      id: IntVO(json['centerId'] as int),
      name: StringVO(json['name'] as String),
      status: StringVO(json['status'] as String),
      closed: StringVO(json['closed'] as String),
      address: StringVO(json['address'] as String),
      image: StringVO(json['image'] ?? ""),
      latitude: DoubleVO(json['latitude'] as double),
      longitude: DoubleVO(json['longitude'] as double),
    );
  }

  @override
  String toString() {
    return 'Center(id: $id, name: $name, status: $status, closed: $closed, address: $address, image: $image, latitude: $latitude, longitude: $longitude)';
  }
}
