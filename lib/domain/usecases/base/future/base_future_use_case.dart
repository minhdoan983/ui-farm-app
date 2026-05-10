import 'package:ui_farm/domain/domain.dart';

abstract class BaseFutureUseCase<Input extends BaseInput, Output extends BaseOutput>
    extends BaseUseCase<Input, Future<Output>> {
  const BaseFutureUseCase();

  Future<Output> execute(Input input) async {
    try {
      final output = await buildUseCase(input);

      return output;
    } catch (e) {
      rethrow;
    }
  }
}
