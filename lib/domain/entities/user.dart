import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
sealed class User with _$User {
  const User._();

  const factory User({
    @Default('') String id,
    @Default('') String name,
    @Default('') String email,
    @Default('') String phone,
    @Default('') String role,
    @Default('') String avatarUrl,
    @Default('') String createdAt,
    @Default('') String updatedAt,
  }) = _User;
}
