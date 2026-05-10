import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_item.freezed.dart';

@freezed
sealed class OrderItem with _$OrderItem {
  const OrderItem._();

  const factory OrderItem({
    @Default('') String id,
    @Default('') String itemId,
    @Default('') String name,
    @Default('') String imgUrl,
    @Default(0) int quantity,
    @Default(0) int price,
    @Default('') String materialSelect,
    @Default('') String colorSelect,
  }) = _OrderItem;
}
