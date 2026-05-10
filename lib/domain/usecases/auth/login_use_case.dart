import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:ui_farm/domain/domain.dart';

part 'login_use_case.freezed.dart';

@injectable
class LoginUseCase extends BaseFutureUseCase<LoginInput, LoginOutput> {
  const LoginUseCase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<LoginOutput> buildUseCase(LoginInput input) async {
    final user = await _authRepository.login(email: input.email, password: input.password);
    return LoginOutput(user: user);
  }
}

@freezed
sealed class LoginInput extends BaseInput with _$LoginInput {
  const LoginInput._();

  const factory LoginInput({required String email, required String password}) = _LoginInput;
}

@freezed
sealed class LoginOutput extends BaseOutput with _$LoginOutput {
  const LoginOutput._();

  const factory LoginOutput({@Default(User()) User user}) = _LoginOutput;
}
