import 'package:freezed_annotation/freezed_annotation.dart';

part 'server_error.freezed.dart';
part 'server_error.g.dart';

@freezed
sealed class ServerError with _$ServerError {
  const factory ServerError({ServerErrorDetail? errors, String? message}) = _ServerError;

  factory ServerError.fromJson(Map<String, dynamic> json) => _$ServerErrorFromJson(json);
}

@freezed
sealed class ServerErrorDetail with _$ServerErrorDetail {
  const factory ServerErrorDetail({String? message}) = _ServerErrorDetail;

  factory ServerErrorDetail.fromJson(Map<String, dynamic> json) =>
      _$ServerErrorDetailFromJson(json);
}
