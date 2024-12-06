import 'package:dartz/dartz.dart';
import 'package:hello_world_mvp/center/domain/failure/center_failure.dart';
import 'package:hello_world_mvp/center/infrastructure/dtos/center_map_res_dto.dart';
import 'package:hello_world_mvp/center/infrastructure/dtos/center_map_res_list_dto.dart';
import 'package:hello_world_mvp/fetch/fetch_service.dart';
import 'package:injectable/injectable.dart';

import '../../../core/value_objects.dart';
import '../../domain/model/center.dart';
import '../../domain/repository/i_center_repository.dart';

@LazySingleton(as: ICenterRepository)
class CenterRepository implements ICenterRepository {
  final FetchService _fetchService;

  CenterRepository(this._fetchService);

  @override
  Future<Either<CenterFetchFailure, List<Center>>> getCenters(
      DoubleVO latitude, DoubleVO longitude, IntVO page, IntVO size) async {
    print("[CenterRepository] getCenters: $latitude, $longitude, $page, $size");

    final failureOrResponse = await _fetchService.request(
      method: HttpMethod.get,
      pathPrefix: "",
      path: '/center/',
      queryParams: {
        'latitude': latitude.getOrCrash().toString(),
        'longitude': longitude.getOrCrash().toString(),
        'page': page.getOrCrash().toString(),
        'size': size.getOrCrash().toString(),
      },
    );

    return failureOrResponse.fold(
      (failure) {
        print("[CenterRepository] getCenters: $failure");
        return Left(CenterFetchFailure(message: "센터 정보를 불러오는데 실패했습니다."));
      },
      (response) {
        try {
          List<Center> centers = [];

          final centerListDto = CenterMapResListDto.fromJson(response.result);
          for (var centerMap in centerListDto.centerMapList) {
            centers.add(centerMap.center);
          }

          return Right(centers);
        } catch (error) {
          return Left(CenterFetchFailure(message: "센터 정보를 파싱하는데 실패했습니다."));
        }
      },
    );
  }
}
