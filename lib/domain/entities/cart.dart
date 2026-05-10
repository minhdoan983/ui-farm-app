import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ui_farm/domain/domain.dart';

part 'cart.freezed.dart';

@freezed
sealed class Cart with _$Cart {
  const Cart._();

  const factory Cart({
    @Default('') String id,
    @Default([]) List<CartItem> cartItems,
    @Default('') String userId,
    @Default(false) bool isActive,
  }) = _Cart;
}
