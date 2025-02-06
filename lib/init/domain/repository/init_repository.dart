import 'package:dartz/dartz.dart';
import 'package:hello_world_mvp/core/value_objects.dart';
import 'package:hello_world_mvp/fetch/failure.dart';
import 'package:hello_world_mvp/fetch/fetch_service.dart';
import 'package:hello_world_mvp/init/infrastructure/repository/i_init_repository.dart';
import 'package:hello_world_mvp/new_chat/domain/service/chat_fetch_service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IInitRepository)
class InitRepository implements IInitRepository {
  final FetchService _fetchService;
  final ChatFetchService _chatFetchService;

  InitRepository(this._fetchService, this._chatFetchService);

  @override
  Future<Either<Failure, Unit>> sendUserLanguage(
      {required int languageId}) async {
    final failureOrResponse = await _fetchService.request(
      method: HttpMethod.post,
      pathPrefix: "",
      path: "/myPage/language/${languageId + 1}",
    );
    return failureOrResponse.fold(
      (failure) => Left(failure),
      (response) => const Right(unit),
    );
  }

  @override
  Future<Either<Failure, StringVO>> getUserLanguage() async {
    final failureOrResponse = await _chatFetchService.request(
      method: HttpMethod.get,
      pathPrefix: "/webflux",
      path: "/user/",
    );
    return failureOrResponse.fold(
      (failure) => Left(failure),
      (response) => Right(StringVO(response.toString())),
    );
  }
}
