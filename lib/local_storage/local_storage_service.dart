import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:hello_world_mvp/local_storage/local_storage_failure.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class LocalStorageService {
  Future<Either<LocalStorageFailure, bool>> write(
      String key, Map<String, dynamic> value) async {
    final prefs = await SharedPreferences.getInstance();
    late bool isSuccess;
    try {
      isSuccess = await prefs.setString(key, json.encode(value));
    } catch (e) {
      return left(LocalStorageFailure(message: e.toString()));
    }
    if (isSuccess) {
      print("LOCAL STORAGE WRITE : $value");
      return right(true);
    } else {
      return left(const LocalStorageFailure(message: "로컬 스토리지 저장에 실했했습니다."));
    }
  }

  Future<Either<LocalStorageFailure, Map<String, dynamic>>> read(
      String key) async {
    final prefs = await SharedPreferences.getInstance();
    final String? value = prefs.getString(key);

    if (value == null) {
      return left(const LocalStorageFailure(message: "해당 키는 비어있습니다."));
    } else {
      print("LOCAL STORAGE READ : $value");
      return right(json.decode(value));
    }
  }

  Future<Either<LocalStorageFailure, Unit>> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();

    try {
      await prefs.remove(key);
    } catch (_) {
      return left(const LocalStorageFailure(message: "삭제에 실패했습니다."));
    }

    return right(unit);
  }
}
