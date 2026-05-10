import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ui_farm/domain/domain.dart';

part 'order.freezed.dart';

enum OrderStatus { pending, approved, cancelled }

@freezed
sealed class Order with _$Order {
  const Order._();

  const factory Order({
    @Default('') String id,
    @Default([]) List<OrderItem> items,
    @Default(OrderStatus.pending) OrderStatus status,
    @Default('') String paypalOrderID,
    @Default('') String createdAt,
  }) = _Order;

  int get totalPrice => items.fold(0, (sum, item) => sum + item.price * item.quantity);
}
