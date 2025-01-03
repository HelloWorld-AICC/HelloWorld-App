import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../fetch/authenticated_http_client.dart';
import '../../../fetch/fetch_service.dart';
import '../../../fetch/network_failure.dart';
import '../../../fetch/server_response.dart';
import '../../presentation/widgets/new_chat_content.dart';

@singleton
@injectable
class ChatFetchService extends FetchService {
  ChatFetchService({required AuthenticatedHttpClient client})
      : super(client: client);

  @override
  Future<Either<NetworkFailure, ServerResponse>> request(
      {required HttpMethod method,
      String pathPrefix = "/webflux",
      required String path,
      Map<String, dynamic>? bodyParam,
      Map<String, dynamic>? pathParams,
      Map<String, dynamic>? queryParams,
      List<File>? files}) async {
    var realPath = "$pathPrefix$path";
    pathParams?.forEach((key, value) {
      realPath = realPath.replaceFirst("{$key}", "$value");
    });

    const String authority = "www.gotoend.store";
    final uri = Uri.https(authority, realPath, queryParams);

    print("API CALL [${method.name}] $uri");

    http.Response response;
    final body = json.encode(bodyParam);

    try {
      switch (method) {
        case HttpMethod.post:
          response = await client.post(
            uri,
            body: body,
          );
          break;
        case HttpMethod.delete:
          response = await client.delete(
            uri,
            body: body,
          );
          break;
        case HttpMethod.patch:
          response = await client.patch(
            uri,
            body: body,
          );
          break;
        case HttpMethod.put:
          response = await client.put(
            uri,
            body: body,
          );
          break;
        default:
          response = await client.get(
            uri,
          );
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

    final jsonData = jsonDecode(utf8.decode(response.bodyBytes));
    final serverResponse = ServerResponse(
      isSuccess: true,
      message: 'Success',
      code: '200',
      result: {"result": jsonData},
    );

    final pathAndQuery = uri.toString().replaceAll(
        "${uri.scheme}://${uri.host}${uri.fragment}${uri.query}", "");

    print("API CALL [${method.name}] $pathAndQuery " +
        (body != 'null' && body.isNotEmpty ? "\n$body" : ""));

    print(
        "API RESPONSE [${method.name}] $pathAndQuery\n${utf8.decode(response.bodyBytes)}");

    return right(serverResponse);
  }

  Future<Either<NetworkFailure, Stream<String>>> streamedRequest({
    required HttpMethod method,
    String pathPrefix = "/webflux",
    required String path,
    Map<String, dynamic>? bodyParam,
    Map<String, dynamic>? queryParams,
  }) async {
    var realPath = "$pathPrefix$path";

    const String authority = "www.gotoend.store";
    final uri = Uri.https(authority, realPath, queryParams);

    final request = http.Request(
      method.toString().split('.').last.toUpperCase(),
      uri,
    );

    request.headers['accept'] = 'text/event-stream';

    if (bodyParam != null) {
      request.body = json.encode(bodyParam);
    }

    try {
      final streamedResponse = await client.send(request);
      client.printRequestDebug('POST', uri,
          headers: request.headers, body: request.body);

      if (streamedResponse.statusCode == 200) {
        final stream = streamedResponse.stream.transform(utf8.decoder);
        final subject = PublishSubject<String>();

        stream.listen(
          (event) {
            subject.add(event);
          },
          onError: (error) {
            subject.addError(error);
          },
          onDone: () {
            subject.close();
          },
        );

        return right(subject.stream);
      } else {
        return left(NetworkFailure.httpError(HttpException(
            'Failed with status code ${streamedResponse.statusCode}')));
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
  }
}
