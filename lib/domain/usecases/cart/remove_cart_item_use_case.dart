// remove_cart_item_use_case.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:ui_farm/domain/domain.dart';

part 'remove_cart_item_use_case.freezed.dart';

@injectable
class RemoveCartItemUseCase extends BaseFutureUseCase<RemoveCartItemInput, RemoveCartItemOutput> {
  const RemoveCartItemUseCase(this._cartRepository);

  final CartRepository _cartRepository;

  @override
  Future<RemoveCartItemOutput> buildUseCase(RemoveCartItemInput input) async {
    await _cartRepository.removeCartItem(userId: input.userId, itemId: input.itemId);
    return const RemoveCartItemOutput();
  }
}

@freezed
sealed class RemoveCartItemInput extends BaseInput with _$RemoveCartItemInput {
  const RemoveCartItemInput._();
  const factory RemoveCartItemInput({required String userId, required String itemId}) =
      _RemoveCartItemInput;
}

@freezed
sealed class RemoveCartItemOutput extends BaseOutput with _$RemoveCartItemOutput {
  const RemoveCartItemOutput._();
  const factory RemoveCartItemOutput() = _RemoveCartItemOutput;
}
