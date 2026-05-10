import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ui_farm/data/data.dart';

part 'order_data.freezed.dart';
part 'order_data.g.dart';

@freezed
sealed class OrderData with _$OrderData {
  const factory OrderData({
    @JsonKey(name: '_id') String? id,
    OrderCartData? cartId,
    String? status,
    String? paypalOrderID,
    String? createdAt,
    String? updatedAt,
  }) = _OrderData;

  factory OrderData.fromJson(Map<String, dynamic> json) => _$OrderDataFromJson(json);
}
