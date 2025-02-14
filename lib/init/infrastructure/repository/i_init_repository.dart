import 'package:dartz/dartz.dart';
import 'package:hello_world_mvp/core/value_objects.dart';
import 'package:hello_world_mvp/fetch/failure.dart';

abstract class IInitRepository {
  Future<Either<Failure, Unit>> sendUserLanguage({required int languageId});

  Future<Either<Failure, StringVO>> getUserLanguage();
}
