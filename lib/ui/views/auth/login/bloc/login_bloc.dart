import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:ui_farm/domain/domain.dart';
import 'package:ui_farm/shared/shared.dart';
import 'package:ui_farm/ui/ui.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

@injectable
class LoginBloc extends BaseBloc<LoginEvent, LoginState> {
  LoginBloc(this._loginUseCase) : super(const LoginState()) {
    on<LoginEmailTextFieldChanged>(_onEmailChanged, transformer: distinct());
    on<LoginPasswordTextFieldChanged>(_onPasswordChanged, transformer: distinct());
    on<LoginButtonPressed>(_onLoginButtonPressed, transformer: log());
    on<LoginPasswordVisibilityPressed>(_onPasswordVisibilityPressed, transformer: log());
  }

  final LoginUseCase _loginUseCase;

  FutureOr<void> _onEmailChanged(LoginEmailTextFieldChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(email: event.email));
  }

  FutureOr<void> _onPasswordChanged(LoginPasswordTextFieldChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(password: event.password));
  }

  FutureOr<void> _onPasswordVisibilityPressed(
    LoginPasswordVisibilityPressed event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  FutureOr<void> _onLoginButtonPressed(LoginButtonPressed event, Emitter<LoginState> emit) async {
    await runBlocCatching(
      doOnSubscribe: () async => emit(state.copyWith(isLoading: true)),
      doOnSuccessOrError: () async => emit(state.copyWith(isLoading: false)),
      action: () async {
        await _loginUseCase.execute(LoginInput(email: state.email, password: state.password));
        emit(state.copyWith(isLoginSuccess: true));
      },
      doOnError: (error) async {
        final message = error is RemoteException ? error.generalMessage : 'Đăng nhập thất bại';
        emit(state.copyWith(errorMessage: message));
      },
    );
  }
}
