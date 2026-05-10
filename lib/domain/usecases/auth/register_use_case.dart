import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:ui_farm/domain/domain.dart';

part 'register_use_case.freezed.dart';

@injectable
class RegisterUseCase extends BaseFutureUseCase<RegisterInput, RegisterOutput> {
  const RegisterUseCase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<RegisterOutput> buildUseCase(RegisterInput input) async {
    final user = await _authRepository.register(
      name: input.name,
      email: input.email,
      phone: input.phone,
      password: input.password,
    );
    return RegisterOutput(user: user);
  }
}

@freezed
sealed class RegisterInput extends BaseInput with _$RegisterInput {
  const RegisterInput._();

  const factory RegisterInput({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) = _RegisterInput;
}

@freezed
sealed class RegisterOutput extends BaseOutput with _$RegisterOutput {
  const RegisterOutput._();

  const factory RegisterOutput({@Default(User()) User user}) = _RegisterOutput;
}
