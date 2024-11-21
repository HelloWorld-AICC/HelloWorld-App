import 'package:hello_world_mvp/core/value_objects.dart';

enum CenterStatus { CLOSED, OPEN }

class Center {
  final StringVO name;
  final CenterStatus status;
  final StringVO closed;
  final StringVO address;
  final StringVO image;
  final DoubleVO latitude;
  final DoubleVO longitude;

  Center({
    required this.name,
    required this.status,
    required this.closed,
    required this.address,
    required this.image,
    required this.latitude,
    required this.longitude,
  });
}
