import 'package:flutter/foundation.dart';
import 'package:ui_farm/domain/domain.dart';

abstract class BaseUseCase<Input extends BaseInput, Output> {
  const BaseUseCase();

  @protected
  Output buildUseCase(Input input);
}
