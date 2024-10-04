import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../fetch/authenticated_http_client.dart';
import '../../../../fetch/fetch_service.dart';
import '../../../../fetch/network_failure.dart';
import '../../../../fetch/server_response.dart';

@singleton
class NoPathPrefixFetchService extends FetchService {
  NoPathPrefixFetchService({required AuthenticatedHttpClient client})
      : super(client: client);

  @override
  Future<Either<NetworkFailure, ServerResponse>> request({
    required HttpMethod method,
    String pathPrefix = "",
    required String path,
    Map<String, dynamic>? bodyParam,
    Map<String, dynamic>? pathParams,
    Map<String, dynamic>? queryParams,
  }) async {
    // body
    final body = json.encode(bodyParam);

    var realPath = "/$path";
    pathParams?.forEach((key, value) {
      realPath = realPath.replaceFirst("{$key}", "$value");
    });

    const String authority = "www.gotoend.store";
    final uri = Uri.https(authority, realPath, queryParams);

    return await super.request(
      method: method,
      path: path,
      bodyParam: bodyParam,
      pathParams: pathParams,
      queryParams: queryParams,
    );
  }
}
