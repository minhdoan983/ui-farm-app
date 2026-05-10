import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ui_farm/data/data.dart';

part 'auth_response_data.freezed.dart';
part 'auth_response_data.g.dart';

@freezed
sealed class AuthResponseData with _$AuthResponseData {
  const factory AuthResponseData({String? accessToken, UserData? user}) = _AuthResponseData;

  factory AuthResponseData.fromJson(Map<String, dynamic> json) => _$AuthResponseDataFromJson(json);
}
