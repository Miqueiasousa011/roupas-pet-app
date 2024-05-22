import 'package:result_dart/result_dart.dart';
import '../../app_exception.dart';

abstract interface class HttpService {
  AsyncResult<dynamic, AppException> get(
    String path, {
    Map<String, String>? headers,
    Map<String, String>? queryParams,
  });
  AsyncResult<dynamic, AppException> post(
    String path, {
    Map<String, String>? headers,
    Object? body,
    Map<String, String>? queryParams,
  });
  AsyncResult<dynamic, AppException> put(
    String path, {
    Map<String, String>? headers,
    Object? body,
    Map<String, String>? queryParams,
  });
  AsyncResult<dynamic, AppException> delete(
    String path, {
    Map<String, String>? headers,
    Object? body,
    Map<String, String>? queryParams,
  });
}
