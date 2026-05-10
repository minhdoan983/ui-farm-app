import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ui_farm/data/data.dart';

part 'order_cart_item_data.freezed.dart';
part 'order_cart_item_data.g.dart';

@freezed
sealed class OrderCartItemData with _$OrderCartItemData {
  const factory OrderCartItemData({
    @JsonKey(name: '_id') String? id,
    ItemData? itemId,
    int? quantity,
    int? price,
    String? materialSelect,
    String? colorSelect,
  }) = _OrderCartItemData;

  factory OrderCartItemData.fromJson(Map<String, dynamic> json) =>
      _$OrderCartItemDataFromJson(json);
}
