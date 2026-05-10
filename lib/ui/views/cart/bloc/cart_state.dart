part of 'cart_bloc.dart';

@freezed
sealed class CartState extends BaseBlocState with _$CartState {
  const CartState._();

  const factory CartState({
    @Default(false) bool isLoading,
    @Default('') String errorMessage,
    @Default({}) Map<String, bool> loadingItems,
  }) = _CartState;
}
