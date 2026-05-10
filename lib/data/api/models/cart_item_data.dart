import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_item_data.freezed.dart';
part 'cart_item_data.g.dart';

@freezed
sealed class CartItemData with _$CartItemData {
  const factory CartItemData({
    @JsonKey(name: '_id') String? id,
    String? itemId,
    int? quantity,
    int? price,
    String? materialSelect,
    String? colorSelect,
    String? createdAt,
    String? updatedAt,
  }) = _CartItemData;

  factory CartItemData.fromJson(Map<String, dynamic> json) => _$CartItemDataFromJson(json);
}
