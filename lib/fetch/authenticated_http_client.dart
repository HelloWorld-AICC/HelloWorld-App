// Dart imports:
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:hello_world_mvp/auth/domain/repository/i_auth_repository.dart';
import 'package:hello_world_mvp/auth/domain/repository/i_token_repository.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class AuthenticatedHttpClient extends http.BaseClient {
  final ITokenRepository tokenRepository;

  AuthenticatedHttpClient({required this.tokenRepository});

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final tokens = await tokenRepository.getTokens();

    return tokens.fold((f) {
      return request.send();
    }, (result) {
      request.headers
          .putIfAbsent('user_id', () => result.atk?.token.getOrCrash() ?? "");

      return request.send();
    });
  }

  void printRequestDebug(String type, Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    var result = "[API-REQUEST] "
        "\t$type $url";

    result += "\n\t[body]: $body\n";

    if (encoding != null) {
      result += "\t[encoding]:$encoding\n";
    }
    result = result.trimRight();
    if (Platform.isAndroid) {
      result = "\x1B[36m$result\x1B[0m";
    }
    debugPrint(result, wrapWidth: 150);
  }

  void printDebugResponse(String type, Response response,
      {bool pretty = false}) {
    var result = "[API-RESPONSE] ${response.statusCode}";

    if (response.request?.url != null) {
      result += '\t$type ${response.request?.url}\n';
    }

    if (response.bodyBytes.isEmpty) {
      result += '\t[body]: ${null}';
    } else {
      if (pretty) {
        result += '\t[body]: ';
        var jsonResult = json.decode(utf8.decode(response.bodyBytes));
        var prettyString =
            const JsonEncoder.withIndent('  ').convert(jsonResult);
        result += prettyString;
      } else {
        result +=
            '\t[body]: ${json.decode(utf8.decode(response.bodyBytes)).toString().replaceAll("\n", " ")}';
      }
    }

    if (Platform.isAndroid) {
      if (response.statusCode.toString().startsWith("2")) {
        result = "\x1B[32m$result\x1B[0m";
      } else {
        result = "\x1B[31m$result\x1B[0m";
      }
    }
    debugPrint(result);
  }

  @override
  Future<String> read(Uri url, {Map<String, String>? headers}) {
    printRequestDebug('READ', url, headers: headers);
    final response = super.read(url, headers: headers);
    return response;
  }

  @override
  Future<Response> get(Uri url, {Map<String, String>? headers}) async {
    printRequestDebug('GET', url, headers: headers);
    final response = await super.get(url, headers: headers);
    printDebugResponse('GET', response);

    return response;
  }

  @override
  Future<Response> post(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    printRequestDebug('POST', url,
        headers: headers, body: body, encoding: encoding);
    final response =
        await super.post(url, headers: headers, body: body, encoding: encoding);
    printDebugResponse('POST', response);
    return response;
  }

  @override
  Future<Response> put(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    printRequestDebug('PUT', url,
        headers: headers, body: body, encoding: encoding);
    final response =
        await super.put(url, headers: headers, body: body, encoding: encoding);
    printDebugResponse('PUT', response);
    return response;
  }

  @override
  Future<Response> patch(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    printRequestDebug('PATCH', url,
        headers: headers, body: body, encoding: encoding);
    final response = await super
        .patch(url, headers: headers, body: body, encoding: encoding);
    printDebugResponse('PATCH', response);
    return response;
  }

  @override
  Future<Response> delete(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    printRequestDebug('DELETE', url,
        headers: headers, body: body, encoding: encoding);

    final response = await super
        .delete(url, headers: headers, body: body, encoding: encoding);
    printDebugResponse('DELETE', response);
    return response;
  }
}
