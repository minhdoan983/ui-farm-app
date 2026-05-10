import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:ui_farm/domain/domain.dart';

part 'check_auth_use_case.freezed.dart';

@injectable
class CheckAuthUseCase extends BaseFutureUseCase<CheckAuthInput, CheckAuthOutput> {
  const CheckAuthUseCase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<CheckAuthOutput> buildUseCase(CheckAuthInput input) async {
    final token = await _authRepository.getToken();
    return CheckAuthOutput(isAuthenticated: token != null && token.isNotEmpty);
  }
}

@freezed
sealed class CheckAuthInput extends BaseInput with _$CheckAuthInput {
  const CheckAuthInput._();

  const factory CheckAuthInput() = _CheckAuthInput;
}

@freezed
sealed class CheckAuthOutput extends BaseOutput with _$CheckAuthOutput {
  const CheckAuthOutput._();

  const factory CheckAuthOutput({@Default(false) bool isAuthenticated}) = _CheckAuthOutput;
}
