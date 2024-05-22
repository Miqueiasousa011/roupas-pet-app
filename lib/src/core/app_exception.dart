sealed class AppException implements Exception {
  final String message;

  const AppException(this.message);
}

final class HttpException extends AppException {
  final dynamic response;
  final int? statusCode;

  HttpException(super.message, {this.response, this.statusCode});
}

final class UnknownException extends AppException {
  const UnknownException(super.message);
}
