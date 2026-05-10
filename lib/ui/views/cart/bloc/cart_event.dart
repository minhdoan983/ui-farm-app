part of 'cart_bloc.dart';

sealed class CartEvent extends BaseBlocEvent {
  const CartEvent();
}

@freezed
sealed class CartItemRemovePressed extends CartEvent with _$CartItemRemovePressed {
  const CartItemRemovePressed._();
  const factory CartItemRemovePressed({required String itemId}) = _CartItemRemovePressed;
}

@freezed
sealed class CartItemQuantityIncreased extends CartEvent with _$CartItemQuantityIncreased {
  const CartItemQuantityIncreased._();
  const factory CartItemQuantityIncreased({required String itemId, required int currentQuantity}) =
      _CartItemQuantityIncreased;
}

@freezed
sealed class CartItemQuantityDecreased extends CartEvent with _$CartItemQuantityDecreased {
  const CartItemQuantityDecreased._();
  const factory CartItemQuantityDecreased({required String itemId, required int currentQuantity}) =
      _CartItemQuantityDecreased;
}
