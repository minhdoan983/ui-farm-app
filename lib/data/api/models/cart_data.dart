import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ui_farm/data/data.dart';

part 'cart_data.freezed.dart';
part 'cart_data.g.dart';

@freezed
sealed class CartData with _$CartData {
  const factory CartData({
    @JsonKey(name: '_id') String? id,
    List<CartItemData>? cartItems,
    String? user,
    bool? isActive,
    String? createdAt,
    String? updatedAt,
  }) = _CartData;

  factory CartData.fromJson(Map<String, dynamic> json) => _$CartDataFromJson(json);
}
