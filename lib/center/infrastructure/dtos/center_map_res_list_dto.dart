import 'center_map_res_dto.dart';

class CenterMapResListDto {
  final List<CenterMapResDto> centerMapResList;

  CenterMapResListDto({required this.centerMapResList});

  factory CenterMapResListDto.fromJson(List<dynamic> json) {
    return CenterMapResListDto(
      centerMapResList: json
          .map((e) => CenterMapResDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  List<CenterMapResDto> toDomain() {
    return centerMapResList;
  }
}
