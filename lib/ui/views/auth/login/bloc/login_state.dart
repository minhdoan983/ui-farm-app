part of 'login_bloc.dart';

@freezed
sealed class LoginState extends BaseBlocState with _$LoginState {
  const LoginState._();

  const factory LoginState({
    @Default('') String email,
    @Default('') String password,
    @Default(false) bool isPasswordVisible,
    @Default(false) bool isLoading,
    @Default(false) bool isLoginSuccess,
    @Default('') String errorMessage,
  }) = _LoginState;
}
