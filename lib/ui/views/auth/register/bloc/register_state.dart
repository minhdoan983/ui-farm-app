part of 'register_bloc.dart';

@freezed
sealed class RegisterState extends BaseBlocState with _$RegisterState {
  const RegisterState._();

  const factory RegisterState({
    @Default('') String name,
    @Default('') String email,
    @Default('') String phone,
    @Default('') String password,
    @Default('') String confirmPassword,
    @Default(false) bool isPasswordVisible,
    @Default(false) bool isLoading,
    @Default(false) bool isRegisterSuccess,
    @Default('') String errorMessage,
  }) = _RegisterState;
}
