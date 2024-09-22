import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hello_world_mvp/fetch/authenticated_http_client.dart';
import 'package:hello_world_mvp/fetch/network_failure.dart';
import 'package:hello_world_mvp/fetch/server_response.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';

import 'fetch_exception.dart';

enum HttpMethod {
  get,
  post,
  delete,
  put,
  patch;
}

@singleton
class FetchService {
  final AuthenticatedHttpClient client;
  final Map<String, String> _baseHeaders = {
    "Content-Type": "application/json; charset=utf-8"
  };

  FetchService({required this.client});

  Future<Either<NetworkFailure, ServerResponse>> request(
      {required HttpMethod method,
      String pathPrefix = "/api/v1",
      required String path,
      Map<String, dynamic>? bodyParam,
      Map<String, dynamic>? pathParams,
      Map<String, dynamic>? queryParams}) async {
    //body
    final body = json.encode(bodyParam);

    //path
    var realPath = "$pathPrefix$path";
    pathParams?.forEach((key, value) {
      realPath = realPath.replaceFirst("{$key}", "$value");
    });

    // debugPrint("CORE :: CORE_API :: request -> $realPath // $queryParams");
    //request

    const String baseUrl = "https://www.gotoend.store/mvc";

    final uri = Uri.https(baseUrl, path, queryParams);

    Response response;

    try {
      switch (method) {
        case HttpMethod.post:
          response = await client.post(
            uri,
            headers: _baseHeaders,
            body: body,
          );
          break;
        case HttpMethod.delete:
          response = await client.delete(
            uri,
            headers: _baseHeaders,
            body: body,
          );
          break;
        case HttpMethod.patch:
          response = await client.patch(
            uri,
            headers: _baseHeaders,
            body: body,
          );
          break;
        case HttpMethod.put:
          response = await client.put(
            uri,
            headers: _baseHeaders,
            body: body,
          );
          break;
        default:
          response = await client.get(
            uri,
            headers: _baseHeaders,
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

  Future<T?> fetchData<T>(
      String url, T Function(Map<String, dynamic>) fromJson) async {
    try {
      final response = await http.get(Uri.parse(url));

      switch (response.statusCode) {
        case 200:
          final Map<String, dynamic> jsonResponse = json.decode(response.body);
          return fromJson(jsonResponse);
        case 400:
          throw FetchException(
              400, 'Bad Request: The server could not understand the request.');
        case 401:
          throw FetchException(401,
              'Unauthorized: Access is denied due to invalid credentials.');
        case 403:
          throw FetchException(403,
              'Forbidden: You do not have permission to access this resource.');
        case 404:
          throw FetchException(
              404, 'Not Found: The requested resource could not be found.');
        case 500:
          throw FetchException(
              500, 'Internal Server Error: An error occurred on the server.');
        case 503:
          throw FetchException(
              503, 'Service Unavailable: The server is currently unavailable.');
        default:
          throw FetchException(
              response.statusCode, 'Unexpected Error: ${response.statusCode}');
      }
    } catch (e) {
      log('Error occurred: $e');
      return null;
    }
  }
}
