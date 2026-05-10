import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:ui_farm/data/data.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  Dio dio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://ui-farm-be-main-1.onrender.com/ui-farm',
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'accept': 'application/json, text/plain, */*',
          'content-type': 'application/json',
        },
      ),
    );

    dio.interceptors.addAll([
      AuthInterceptor(),
      LogInterceptor(
        // 👈 có sẵn trong dio
        requestBody: true,
        responseBody: true,
        requestHeader: false,
        responseHeader: false,
        logPrint: (log) => debugPrint(log.toString()),
      ),
    ]);

    return dio;
  }

  @lazySingleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage();
}
