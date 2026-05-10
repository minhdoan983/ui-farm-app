import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:ui_farm/domain/domain.dart';

part 'update_profile_use_case.freezed.dart';

@injectable
class UpdateProfileUseCase extends BaseFutureUseCase<UpdateProfileInput, UpdateProfileOutput> {
  const UpdateProfileUseCase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<UpdateProfileOutput> buildUseCase(UpdateProfileInput input) async {
    final user = await _authRepository.updateProfile(
      userId: input.userId,
      name: input.name,
      phone: input.phone,
    );
    return UpdateProfileOutput(user: user);
  }
}

@freezed
sealed class UpdateProfileInput extends BaseInput with _$UpdateProfileInput {
  const UpdateProfileInput._();

  const factory UpdateProfileInput({
    required String userId,
    required String name,
    required String phone,
  }) = _UpdateProfileInput;
}

@freezed
sealed class UpdateProfileOutput extends BaseOutput with _$UpdateProfileOutput {
  const UpdateProfileOutput._();

  const factory UpdateProfileOutput({@Default(User()) User user}) = _UpdateProfileOutput;
}
