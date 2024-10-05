import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';

import '../../../../fetch/authenticated_http_client.dart';
import '../../../../fetch/fetch_service.dart';
import '../../../../fetch/network_failure.dart';
import '../../../../fetch/server_response.dart';

@singleton
class WebFluxFetchService extends FetchService {
  WebFluxFetchService({required AuthenticatedHttpClient client})
      : super(client: client);

  final Map<String, String> _baseHeaders = {
    "Content-Type": "application/json; charset=utf-8"
  };

  @override
  Future<Either<NetworkFailure, ServerResponse>> request({
    required HttpMethod method,
    String pathPrefix = '',
    required String path,
    Map<String, dynamic>? bodyParam,
    Map<String, dynamic>? pathParams,
    Map<String, dynamic>? queryParams,
    Map<String, String>? additionalHeaders,
  }) async {
    // body
    final body = json.encode(bodyParam);

    var realPath = "/webflux$pathPrefix$path";
    pathParams?.forEach((key, value) {
      realPath = realPath.replaceFirst("{$key}", "$value");
    });

    const String authority = "www.gotoend.store";
    final uri = Uri.https(authority, realPath, queryParams);

    Response response;

    final headers = {
      ..._baseHeaders,
      if (additionalHeaders != null) ...additionalHeaders
    };
    log("headers: $headers");
    log("uri: $uri");

    try {
      switch (method) {
        case HttpMethod.post:
          response = await client.post(
            uri,
            headers: headers,
            body: body,
          );
          break;
        case HttpMethod.delete:
          response = await client.delete(
            uri,
            headers: headers,
            body: body,
          );
          break;
        case HttpMethod.patch:
          response = await client.patch(
            uri,
            headers: headers,
            body: body,
          );
          break;
        case HttpMethod.put:
          response = await client.put(
            uri,
            headers: headers,
            body: body,
          );
          break;
        default:
          response = await client.get(
            uri,
            headers: headers,
          );
          break;
      }
    } on SocketException catch (e) {
      return left(NetworkFailure.socketError(e));
    } on ClientException catch (e) {
      return left(NetworkFailure.clientError(e));
    } on HttpException catch (e) {
      return left(NetworkFailure.httpError(e));
    } on FormatException catch (e) {
      return left(NetworkFailure.formatError(e));
    } catch (e) {
      return left(NetworkFailure.unknownError(e));
    }

    final ServerResponse serverResponse =
        ServerResponse.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));

    final pathAndQuery = uri.toString().replaceAll(
        "${uri.scheme}://${uri.host}${uri.fragment}${uri.query}", "");

    print("API CALL [${method.name}] $pathAndQuery " +
        (body != 'null' && body.isNotEmpty ? "\n$body" : ""));

    print(
        "API RESPONSE [${method.name}] $pathAndQuery\n${utf8.decode(response.bodyBytes)}");

    return right(serverResponse);
  }
}
