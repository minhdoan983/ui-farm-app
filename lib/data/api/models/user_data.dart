import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_data.freezed.dart';
part 'user_data.g.dart';

@freezed
sealed class UserData with _$UserData {
  const factory UserData({
    @JsonKey(name: '_id') String? id,
    String? name,
    String? email,
    String? phone,
    String? role,
    String? avatarUrl,
    String? createdAt,
    String? updatedAt,
  }) = _UserData;

  factory UserData.fromJson(Map<String, dynamic> json) => _$UserDataFromJson(json);
}
