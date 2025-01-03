import '../../../core/value_objects.dart';
import '../../domain/model/center.dart';

class CenterMapResDto {
  final Center center;

  CenterMapResDto({
    required this.center,
  });

  factory CenterMapResDto.fromJson(Map<String, dynamic> json) {
    return CenterMapResDto(
      center: Center.fromJson(json as Map<String, dynamic>),
    );
  }
}
