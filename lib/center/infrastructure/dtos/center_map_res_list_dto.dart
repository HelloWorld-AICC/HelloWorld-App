import 'center_map_res_dto.dart';

class CenterMapResListDto {
  final List<CenterMapResDto> centerMapList;
  final String userId;

  CenterMapResListDto({
    required this.centerMapList,
    required this.userId,
  });

  factory CenterMapResListDto.fromJson(Map<String, dynamic> json) {
    CenterMapResListDto temp;

    try {
      print("Parsing centerMapList...");

      if (json['centerMapList'] != null) {
        var centerMapList = (json['centerMapList'] as List<dynamic>)
            .where((e) => e != null) // null 값 제외
            .map((e) {
          print("Parsing element: $e");
          return CenterMapResDto.fromJson(e as Map<String, dynamic>);
        }).toList();

        print("Parsing userId...");
        String userId = json['userId'] as String;

        temp = CenterMapResListDto(
          centerMapList: centerMapList,
          userId: userId,
        );

        print("CenterMapResListDto successfully created: $temp");
      } else {
        print("Error: centerMapList is null");
      }
    } catch (e, stacktrace) {
      print("Error occurred: $e");
      print("Stacktrace: $stacktrace");
    }

    return CenterMapResListDto(
      centerMapList: (json['centerMapList'] as List<dynamic>)
          .map((e) => CenterMapResDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      userId: json['userId'] as String,
    );
  }

  List<CenterMapResDto> toDomain() {
    return centerMapList;
  }
}
