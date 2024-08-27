class FetchException implements Exception {
  final int statusCode;
  final String message;

  FetchException(this.statusCode, this.message);

  @override
  String toString() => 'FetchException: $statusCode - $message';
}
