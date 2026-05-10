import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:ui_farm/domain/domain.dart';

part 'update_cart_quantity_use_case.freezed.dart';

@injectable
class UpdateCartQuantityUseCase
    extends BaseFutureUseCase<UpdateCartQuantityInput, UpdateCartQuantityOutput> {
  const UpdateCartQuantityUseCase(this._cartRepository);

  final CartRepository _cartRepository;

  @override
  Future<UpdateCartQuantityOutput> buildUseCase(UpdateCartQuantityInput input) async {
    await _cartRepository.updateCartQuantity(
      userId: input.userId,
      itemId: input.itemId,
      quantity: input.quantity,
    );
    return const UpdateCartQuantityOutput();
  }
}

@freezed
sealed class UpdateCartQuantityInput extends BaseInput with _$UpdateCartQuantityInput {
  const UpdateCartQuantityInput._();
  const factory UpdateCartQuantityInput({
    required String userId,
    required String itemId,
    required int quantity,
  }) = _UpdateCartQuantityInput;
}

@freezed
sealed class UpdateCartQuantityOutput extends BaseOutput with _$UpdateCartQuantityOutput {
  const UpdateCartQuantityOutput._();
  const factory UpdateCartQuantityOutput() = _UpdateCartQuantityOutput;
}
