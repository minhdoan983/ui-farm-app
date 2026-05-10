import 'package:ui_farm/domain/domain.dart';

abstract class BaseSyncUseCase<Input extends BaseInput, Output extends BaseOutput>
    extends BaseUseCase<Input, Output> {
  const BaseSyncUseCase();

  Output execute(Input input) {
    try {
      final output = buildUseCase(input);

      return output;
    } catch (e) {
      rethrow;
    }
  }
}
