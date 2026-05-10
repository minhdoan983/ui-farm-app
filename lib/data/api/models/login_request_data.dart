import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_request_data.freezed.dart';
part 'login_request_data.g.dart';

@freezed
sealed class LoginRequestData with _$LoginRequestData {
  const factory LoginRequestData({String? email, String? password}) = _LoginRequestData;

  factory LoginRequestData.fromJson(Map<String, dynamic> json) => _$LoginRequestDataFromJson(json);
}
