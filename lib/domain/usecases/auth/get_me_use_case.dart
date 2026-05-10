import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:ui_farm/domain/domain.dart';

part 'get_me_use_case.freezed.dart';

@injectable
class GetMeUseCase extends BaseFutureUseCase<GetMeInput, GetMeOutput> {
  const GetMeUseCase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<GetMeOutput> buildUseCase(GetMeInput input) async {
    final user = await _authRepository.getMe();
    return GetMeOutput(user: user);
  }
}

@freezed
sealed class GetMeInput extends BaseInput with _$GetMeInput {
  const GetMeInput._();
  const factory GetMeInput() = _GetMeInput;
}

@freezed
sealed class GetMeOutput extends BaseOutput with _$GetMeOutput {
  const GetMeOutput._();
  const factory GetMeOutput({@Default(User()) User user}) = _GetMeOutput;
}
