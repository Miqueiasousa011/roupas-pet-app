import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:result_dart/functions.dart';
import 'package:result_dart/result_dart.dart';

import '../../app_exception.dart';
import '../local_storage/local_storage_service.dart';
import 'http_service.dart';

final class DioService implements HttpService {
  final String baseURL;
  final LocalStorageService _storage;
  late final Dio _dio;

  DioService(this.baseURL, this._storage) {
    _dio = Dio(BaseOptions(baseUrl: baseURL));
    _dio.interceptors.add(_CustomInterceptor(_storage));
  }

  @override
  AsyncResult<dynamic, AppException> get(
    String path, {
    Map<String, String>? headers,
    Map<String, String>? queryParams,
  }) async {
    try {
      final response =
          await _dio.get(path, queryParameters: queryParams, options: Options(headers: headers));

      return Success(response.data);
    } on DioException catch (e) {
      return failureOf(
        HttpException(
          e.response?.data['error'] ??
              e.response?.data['message'] ??
              e.message ??
              'something_went_wrong',
          statusCode: e.response?.statusCode,
          response: e.response,
        ),
      );
    } on Exception catch (e) {
      return Failure(UnknownException('something_went_wrong/$e'));
    }
  }

  @override
  AsyncResult<dynamic, AppException> post(
    String path, {
    Map<String, String>? headers,
    Object? body,
    Map<String, String>? queryParams,
  }) async {
    try {
      final response = await _dio.post(path,
          data: body, queryParameters: queryParams, options: Options(headers: headers));

      return Success(response.data);
    } on DioException catch (e) {
      return Failure(
        HttpException(
          e.response?.data['error'] ??
              e.response?.data['message'] ??
              e.message ??
              'something_went_wrong',
          statusCode: e.response?.statusCode,
          response: e.response?.data,
        ),
      );
    } on Exception catch (e) {
      return Failure(UnknownException('something_went_wrong/$e'));
    }
  }

  @override
  AsyncResult<dynamic, AppException> put(
    String path, {
    Map<String, String>? headers,
    Object? body,
    Map<String, String>? queryParams,
  }) async {
    try {
      final response = await _dio.put(path,
          data: body, queryParameters: queryParams, options: Options(headers: headers));

      return Success(response.data);
    } on DioException catch (e) {
      return Failure(
        HttpException(
          e.response?.data['error'] ??
              e.response?.data['message'] ??
              e.message ??
              'something_went_wrong',
          statusCode: e.response?.statusCode,
          response: e.response,
        ),
      );
    } on Exception catch (e) {
      return Failure(UnknownException('something_went_wrong/$e'));
    }
  }

  @override
  AsyncResult<dynamic, AppException> delete(
    String path, {
    Map<String, String>? headers,
    Object? body,
    Map<String, String>? queryParams,
  }) async {
    try {
      final response = await _dio.delete(path,
          data: body, queryParameters: queryParams, options: Options(headers: headers));

      return Success(response.data);
    } on DioException catch (e) {
      return Failure(
        HttpException(
          e.response?.data['error'] ??
              e.response?.data['message'] ??
              e.message ??
              'something_went_wrong',
          statusCode: e.response?.statusCode,
          response: e.response,
        ),
      );
    } on Exception catch (e) {
      return Failure(UnknownException('something_went_wrong/$e'));
    }
  }
}

class _CustomInterceptor extends InterceptorsWrapper {
  final Stopwatch sw = Stopwatch();
  final LocalStorageService _storage;

  _CustomInterceptor(this._storage);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (kDebugMode) {
      sw.start();
    }

    final token = await _storage.get<String?>('token');

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      print(err.response?.data);
      print(
          '[${err.requestOptions.method}] - ${err.requestOptions.path} | ${err.response?.statusCode} | ${sw.elapsedMilliseconds} ms');
      sw.stop();
      sw.reset();
    }

    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      final queryParams = response.requestOptions.queryParameters.entries
          .map((e) => '${e.key}=${e.value}')
          .join('&');
      print(
          '[${response.requestOptions.method}] - ${response.requestOptions.path}${queryParams.isEmpty ? '' : '?$queryParams'} | ${response.statusCode} | ${sw.elapsedMilliseconds} ms');
      sw.stop();
      sw.reset();
    }
    super.onResponse(response, handler);
  }
}
