part of 'register_bloc.dart';

sealed class RegisterEvent extends BaseBlocEvent {
  const RegisterEvent();
}

@freezed
sealed class RegisterViewInitiated extends RegisterEvent with _$RegisterViewInitiated {
  const RegisterViewInitiated._();
  const factory RegisterViewInitiated() = _RegisterViewInitiated;
}

@freezed
sealed class RegisterNameTextFieldChanged extends RegisterEvent
    with _$RegisterNameTextFieldChanged {
  const RegisterNameTextFieldChanged._();
  const factory RegisterNameTextFieldChanged({required String name}) =
      _RegisterNameTextFieldChanged;
}

@freezed
sealed class RegisterEmailTextFieldChanged extends RegisterEvent
    with _$RegisterEmailTextFieldChanged {
  const RegisterEmailTextFieldChanged._();
  const factory RegisterEmailTextFieldChanged({required String email}) =
      _RegisterEmailTextFieldChanged;
}

@freezed
sealed class RegisterPhoneTextFieldChanged extends RegisterEvent
    with _$RegisterPhoneTextFieldChanged {
  const RegisterPhoneTextFieldChanged._();
  const factory RegisterPhoneTextFieldChanged({required String phone}) =
      _RegisterPhoneTextFieldChanged;
}

@freezed
sealed class RegisterPasswordTextFieldChanged extends RegisterEvent
    with _$RegisterPasswordTextFieldChanged {
  const RegisterPasswordTextFieldChanged._();
  const factory RegisterPasswordTextFieldChanged({required String password}) =
      _RegisterPasswordTextFieldChanged;
}

@freezed
sealed class RegisterConfirmPasswordTextFieldChanged extends RegisterEvent
    with _$RegisterConfirmPasswordTextFieldChanged {
  const RegisterConfirmPasswordTextFieldChanged._();
  const factory RegisterConfirmPasswordTextFieldChanged({required String confirmPassword}) =
      _RegisterConfirmPasswordTextFieldChanged;
}

@freezed
sealed class RegisterPasswordVisibilityPressed extends RegisterEvent
    with _$RegisterPasswordVisibilityPressed {
  const RegisterPasswordVisibilityPressed._();
  const factory RegisterPasswordVisibilityPressed() = _RegisterPasswordVisibilityPressed;
}

@freezed
sealed class RegisterButtonPressed extends RegisterEvent with _$RegisterButtonPressed {
  const RegisterButtonPressed._();
  const factory RegisterButtonPressed() = _RegisterButtonPressed;
}
