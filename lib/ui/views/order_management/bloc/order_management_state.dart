part of 'order_management_bloc.dart';

@freezed
sealed class OrderManagementState extends BaseBlocState with _$OrderManagementState {
  const OrderManagementState._();

  const factory OrderManagementState({
    @Default([]) List<Order> orders,
    @Default(false) bool isLoading,
    @Default('') String errorMessage,
  }) = _OrderManagementState;

  List<Order> get pendingOrders => orders.where((o) => o.status == OrderStatus.pending).toList();

  List<Order> get approvedOrders => orders.where((o) => o.status == OrderStatus.approved).toList();

  List<Order> get cancelledOrders =>
      orders.where((o) => o.status == OrderStatus.cancelled).toList();
}
