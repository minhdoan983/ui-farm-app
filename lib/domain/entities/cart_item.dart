import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_item.freezed.dart';

@freezed
sealed class CartItem with _$CartItem {
  const CartItem._();

  const factory CartItem({
    @Default('') String id,
    @Default('') String itemId,
    @Default(0) int quantity,
    @Default(0) int price,
    @Default('') String materialSelect,
    @Default('') String colorSelect,
    @Default('') String name,
    @Default('') String imgUrl,
  }) = _CartItem;
}
