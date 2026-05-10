import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:ui_farm/domain/domain.dart';
import 'package:ui_farm/shared/shared.dart';
import 'package:ui_farm/ui/ui.dart';

part 'register_event.dart';
part 'register_state.dart';
part 'register_bloc.freezed.dart';

@injectable
class RegisterBloc extends BaseBloc<RegisterEvent, RegisterState> {
  RegisterBloc(this._registerUseCase) : super(const RegisterState()) {
    on<RegisterViewInitiated>(_onViewInitiated);
    on<RegisterNameTextFieldChanged>(_onNameChanged);
    on<RegisterEmailTextFieldChanged>(_onEmailChanged);
    on<RegisterPhoneTextFieldChanged>(_onPhoneChanged);
    on<RegisterPasswordTextFieldChanged>(_onPasswordChanged);
    on<RegisterConfirmPasswordTextFieldChanged>(_onConfirmPasswordChanged);
    on<RegisterPasswordVisibilityPressed>(_onPasswordVisibilityPressed);
    on<RegisterButtonPressed>(_onRegisterButtonPressed);
  }

  final RegisterUseCase _registerUseCase;

  FutureOr<void> _onViewInitiated(RegisterViewInitiated event, Emitter<RegisterState> emit) {}

  FutureOr<void> _onNameChanged(RegisterNameTextFieldChanged event, Emitter<RegisterState> emit) {
    emit(state.copyWith(name: event.name, errorMessage: ''));
  }

  FutureOr<void> _onEmailChanged(RegisterEmailTextFieldChanged event, Emitter<RegisterState> emit) {
    emit(state.copyWith(email: event.email, errorMessage: ''));
  }

  FutureOr<void> _onPhoneChanged(RegisterPhoneTextFieldChanged event, Emitter<RegisterState> emit) {
    emit(state.copyWith(phone: event.phone, errorMessage: ''));
  }

  FutureOr<void> _onPasswordChanged(
    RegisterPasswordTextFieldChanged event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(password: event.password, errorMessage: ''));
  }

  FutureOr<void> _onConfirmPasswordChanged(
    RegisterConfirmPasswordTextFieldChanged event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(confirmPassword: event.confirmPassword, errorMessage: ''));
  }

  FutureOr<void> _onPasswordVisibilityPressed(
    RegisterPasswordVisibilityPressed event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  FutureOr<void> _onRegisterButtonPressed(
    RegisterButtonPressed event,
    Emitter<RegisterState> emit,
  ) async {
    if (state.password != state.confirmPassword) {
      emit(state.copyWith(errorMessage: 'Mật khẩu xác nhận không khớp'));
      return;
    }

    await runBlocCatching(
      doOnSubscribe: () async => emit(state.copyWith(isLoading: true)),
      doOnSuccessOrError: () async => emit(state.copyWith(isLoading: false)),
      action: () async {
        await _registerUseCase.execute(
          RegisterInput(
            name: state.name,
            email: state.email,
            phone: state.phone,
            password: state.password,
          ),
        );
        emit(state.copyWith(isRegisterSuccess: true));
      },
      doOnError: (error) async {
        final message = error is RemoteException ? error.generalMessage : 'Đăng ký thất bại';
        emit(state.copyWith(errorMessage: message));
      },
    );
  }
}
