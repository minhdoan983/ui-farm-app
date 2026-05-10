import 'package:ui_farm/shared/shared.dart';

enum ExceptionKind { connectTimeout, receiveTimeout, badResponse, cancel, unknown }

abstract class AppException implements Exception {
  const AppException();
}

class RemoteException extends AppException {
  const RemoteException({required this.kind, this.serverError});

  final ExceptionKind kind;
  final ServerError? serverError;

  String get generalMessage =>
      serverError?.errors?.message ?? serverError?.message ?? 'Đã có lỗi xảy ra, vui lòng thử lại';
}
