import 'dart:io';

import 'package:hello_world_mvp/fetch/failure.dart';
import 'package:http/http.dart';

class NetworkFailure extends Failure {
  final String info;

  const NetworkFailure({
    required super.message,
    required this.info,
  });
  @override
  List<Object?> get props => [message, info];

  NetworkFailure.socketError(SocketException e)
      : info =
            'Socket Error : ${e.message} ${e.osError?.message} ${e.address} ${e.port}',
        super(message: "인터넷 연결이 원활하지 않습니다. 네트워크 상태를 확인해주세요. (소켓 오류)");

  NetworkFailure.clientError(ClientException e)
      : info = 'Client Error : ${e.message} ${e.uri}',
        super(message: "인터넷 연결이 원활하지 않습니다. 네트워크 상태를 확인해주세요. (클라이언트 오류)");

  NetworkFailure.httpError(HttpException e)
      : info = 'Http Error : ${e.message} ${e.uri}',
        super(message: "인터넷 연결이 원활하지 않습니다. 네트워크 상태를 확인해주세요. (HTTP 오류)");

  NetworkFailure.formatError(FormatException e)
      : info = 'Format Error : ${e.message} ${e.source} ${e.offset}',
        super(message: "인터넷 연결이 원활하지 않습니다. 네트워크 상태를 확인해주세요. (포맷 오류)");

  NetworkFailure.authError(Response r)
      : info = 'Auth Error : ${r.statusCode}',
        super(message: "권한이 없습니다.");

  NetworkFailure.unknownError(Object e)
      : info = e.toString(),
        super(message: "인터넷 연결이 원활하지 않습니다. 네트워크 상태를 확인해주세요. (알 수 없는 오류)");
}
