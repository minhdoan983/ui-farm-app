import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ui_farm/data/data.dart';

part 'order_cart_data.freezed.dart';
part 'order_cart_data.g.dart';

@freezed
sealed class OrderCartData with _$OrderCartData {
  const factory OrderCartData({
    @JsonKey(name: '_id') String? id,
    List<OrderCartItemData>? cartItems,
    String? user,
    bool? isActive,
  }) = _OrderCartData;

  factory OrderCartData.fromJson(Map<String, dynamic> json) => _$OrderCartDataFromJson(json);
}
