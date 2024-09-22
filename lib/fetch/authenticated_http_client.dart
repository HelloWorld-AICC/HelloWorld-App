// Dart imports:
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
// import 'package:kc_user/infrastructure/hive/hive_provider.dart';
// import 'package:kc_user/refactor-v1/env/env_manager.dart';

@LazySingleton()
class AuthenticatedHttpClient extends http.BaseClient {
  // final HiveProvider hiveProvider;

  // FirebasePerformance performance = FirebasePerformance.instance;

  // TODO retry 할 일 있으면 고려해보기
  // https://pub.dev/packages/http#retrying-requests
  // AuthenticatedHttpClient({required this.hiveProvider});

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    // final accessToken = await hiveProvider.getAuthToken();
    // final waitingToken = await hiveProvider.getWaitingToken();
    // request.headers.putIfAbsent('x-access-token', () => accessToken);
    // request.headers.putIfAbsent('x-waiting-token', () => waitingToken);
    // debugPrint("[HEADER]: ${waitingToken.isEmpty} ${waitingToken}\n");
    return request.send();
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
    // final HttpMetric metric =
    //     performance.newHttpMetric(url.toString(), HttpMethod.Get);
    // await metric.start();

    final response = await super.get(url, headers: headers);

    // metric.responseContentType = response.headers['Content-Type'];
    // metric.httpResponseCode = response.statusCode;
    // metric.responsePayloadSize = response.contentLength;
    // await metric.stop();
    printDebugResponse('GET', response);

    return response;
  }

  @override
  Future<Response> post(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    printRequestDebug('POST', url,
        headers: headers, body: body, encoding: encoding);
    // final HttpMetric metric =
    //     performance.newHttpMetric(url.toString(), HttpMethod.Post);
    // await metric.start();
    final response =
        await super.post(url, headers: headers, body: body, encoding: encoding);
    // metric.responseContentType = response.headers['Content-Type'];
    // metric.httpResponseCode = response.statusCode;
    // metric.responsePayloadSize = response.contentLength;
    // await metric.stop();
    printDebugResponse('POST', response);
    return response;
  }

  @override
  Future<Response> put(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    printRequestDebug('PUT', url,
        headers: headers, body: body, encoding: encoding);
    // final HttpMetric metric =
    //     performance.newHttpMetric(url.toString(), HttpMethod.Put);
    // await metric.start();
    final response =
        await super.put(url, headers: headers, body: body, encoding: encoding);
    // metric.responseContentType = response.headers['Content-Type'];
    // metric.httpResponseCode = response.statusCode;
    // metric.responsePayloadSize = response.contentLength;
    // await metric.stop();
    printDebugResponse('PUT', response);
    return response;
  }

  @override
  Future<Response> patch(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    printRequestDebug('PATCH', url,
        headers: headers, body: body, encoding: encoding);
    // final HttpMetric metric =
    //     performance.newHttpMetric(url.toString(), HttpMethod.Patch);
    // await metric.start();
    final response = await super
        .patch(url, headers: headers, body: body, encoding: encoding);
    // metric.responseContentType = response.headers['Content-Type'];
    // metric.httpResponseCode = response.statusCode;
    // metric.responsePayloadSize = response.contentLength;
    // await metric.stop();
    printDebugResponse('PATCH', response);
    return response;
  }

  @override
  Future<Response> delete(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    printRequestDebug('DELETE', url,
        headers: headers, body: body, encoding: encoding);

    // final HttpMetric metric =
    //     performance.newHttpMetric(url.toString(), HttpMethod.Delete);
    // await metric.start();

    final response = await super
        .delete(url, headers: headers, body: body, encoding: encoding);
    // metric.responseContentType = response.headers['Content-Type'];
    // metric.httpResponseCode = response.statusCode;
    // metric.responsePayloadSize = response.contentLength;
    // await metric.stop();
    printDebugResponse('DELETE', response);
    return response;
  }
}
