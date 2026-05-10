part of 'login_bloc.dart';

sealed class LoginEvent extends BaseBlocEvent {
  const LoginEvent();
}

@freezed
sealed class LoginEmailTextFieldChanged extends LoginEvent with _$LoginEmailTextFieldChanged {
  const LoginEmailTextFieldChanged._();
  const factory LoginEmailTextFieldChanged({required String email}) = _LoginEmailTextFieldChanged;
}

@freezed
sealed class LoginPasswordTextFieldChanged extends LoginEvent with _$LoginPasswordTextFieldChanged {
  const LoginPasswordTextFieldChanged._();
  const factory LoginPasswordTextFieldChanged({required String password}) =
      _LoginPasswordTextFieldChanged;
}

@freezed
sealed class LoginButtonPressed extends LoginEvent with _$LoginButtonPressed {
  const LoginButtonPressed._();
  const factory LoginButtonPressed() = _LoginButtonPressed;
}

@freezed
sealed class LoginPasswordVisibilityPressed extends LoginEvent
    with _$LoginPasswordVisibilityPressed {
  const LoginPasswordVisibilityPressed._();
  const factory LoginPasswordVisibilityPressed() = _LoginPasswordVisibilityPressed;
}
