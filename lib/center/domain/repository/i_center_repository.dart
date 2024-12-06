import 'package:dartz/dartz.dart';

import '../../../core/value_objects.dart';
import '../failure/center_failure.dart';
import '../model/center.dart';

abstract class ICenterRepository {
  Future<Either<CenterFetchFailure, List<Center>>> getCenters(
      DoubleVO latitude, DoubleVO longitude, IntVO page, IntVO size);
}
