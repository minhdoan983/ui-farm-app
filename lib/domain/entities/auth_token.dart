import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_token.freezed.dart';

@freezed
sealed class AuthToken with _$AuthToken {
  const AuthToken._();

  const factory AuthToken({@Default('') String accessToken}) = _AuthToken;
}
