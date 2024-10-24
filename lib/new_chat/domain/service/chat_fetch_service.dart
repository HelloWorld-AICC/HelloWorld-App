import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../../../fetch/authenticated_http_client.dart';
import '../../../fetch/fetch_service.dart';
import '../../../fetch/network_failure.dart';
import '../../../fetch/server_response.dart';

@singleton
class ChatFetchService extends FetchService {
  ChatFetchService({required AuthenticatedHttpClient client})
      : super(client: client);

  final Map<String, String> _baseHeaders = {
    "Content-Type": "application/json; charset=utf-8"
  };

  @override
  Future<Either<NetworkFailure, ServerResponse>> request(
      {required HttpMethod method,
      String pathPrefix = "/api/v1", // 기본값 유지
      required String path,
      Map<String, dynamic>? bodyParam,
      Map<String, dynamic>? pathParams,
      Map<String, dynamic>? queryParams}) async {
    var realPath = "$pathPrefix$path";
    pathParams?.forEach((key, value) {
      realPath = realPath.replaceFirst("{$key}", "$value");
    });

    const String authority = "www.gotoend.store";
    final uri = Uri.https(authority, realPath, queryParams);

    http.Response response;
    final body = json.encode(bodyParam);

    try {
      switch (method) {
        case HttpMethod.post:
          response = await client.post(uri, headers: _baseHeaders, body: body);
          break;
        case HttpMethod.delete:
          response =
              await client.delete(uri, headers: _baseHeaders, body: body);
          break;
        case HttpMethod.patch:
          response = await client.patch(uri, headers: _baseHeaders, body: body);
          break;
        case HttpMethod.put:
          response = await client.put(uri, headers: _baseHeaders, body: body);
          break;
        default:
          response = await client.get(uri, headers: _baseHeaders);
          break;
      }
    } on SocketException catch (e) {
      return left(NetworkFailure.socketError(e));
    } on http.ClientException catch (e) {
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

    return right(serverResponse);
  }
}
