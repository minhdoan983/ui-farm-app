import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:ui_farm/shared/shared.dart';

enum RequestMethod { get, post, put, patch, delete }

@lazySingleton
class ServerApiClient {
  const ServerApiClient(this._dio);

  final Dio _dio;

  Future<T?> request<T>({
    required RequestMethod method,
    required String path,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    required T Function(dynamic data) decoder,
  }) async {
    try {
      final Response response;

      switch (method) {
        case RequestMethod.get:
          response = await _dio.get(path, queryParameters: queryParameters);
        case RequestMethod.post:
          response = await _dio.post(path, data: body);
        case RequestMethod.put:
          response = await _dio.put(path, data: body);
        case RequestMethod.delete:
          response = await _dio.delete(path, data: body);
        case RequestMethod.patch:
          response = await _dio.patch(path, data: body);
      }

      final responseData = response.data;

      if (responseData is Map<String, dynamic> && responseData.containsKey('data')) {
        return decoder(responseData['data']);
      }

      return decoder(responseData);
    } on DioException catch (e) {
      throw RemoteException(
        kind: _mapDioError(e),
        serverError: e.response?.data != null
            ? ServerError.fromJson(e.response!.data as Map<String, dynamic>)
            : null,
      );
    }
  }

  ExceptionKind _mapDioError(DioException e) {
    return switch (e.type) {
      DioExceptionType.connectionTimeout => ExceptionKind.connectTimeout,
      DioExceptionType.receiveTimeout => ExceptionKind.receiveTimeout,
      DioExceptionType.badResponse => ExceptionKind.badResponse,
      DioExceptionType.cancel => ExceptionKind.cancel,
      _ => ExceptionKind.unknown,
    };
  }
}
