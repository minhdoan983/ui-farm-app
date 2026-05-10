import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:ui_farm/domain/domain.dart';

part 'get_cart_use_case.freezed.dart';

@injectable
class GetCartUseCase extends BaseFutureUseCase<GetCartInput, GetCartOutput> {
  const GetCartUseCase(this._cartRepository);

  final CartRepository _cartRepository;

  @override
  Future<GetCartOutput> buildUseCase(GetCartInput input) async {
    final cart = await _cartRepository.getCart(userId: input.userId);
    return GetCartOutput(cart: cart);
  }
}

@freezed
sealed class GetCartInput extends BaseInput with _$GetCartInput {
  const GetCartInput._();
  const factory GetCartInput({required String userId}) = _GetCartInput;
}

@freezed
sealed class GetCartOutput extends BaseOutput with _$GetCartOutput {
  const GetCartOutput._();
  const factory GetCartOutput({@Default(Cart()) Cart cart}) = _GetCartOutput;
}
