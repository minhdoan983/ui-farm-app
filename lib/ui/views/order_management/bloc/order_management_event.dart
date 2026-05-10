part of 'order_management_bloc.dart';

sealed class OrderManagementEvent extends BaseBlocEvent {
  const OrderManagementEvent();
}

@freezed
sealed class OrderManagementViewInitiated extends OrderManagementEvent
    with _$OrderManagementViewInitiated {
  const OrderManagementViewInitiated._();
  const factory OrderManagementViewInitiated() = _OrderManagementViewInitiated;
}

@freezed
sealed class OrderManagementRefreshed extends OrderManagementEvent with _$OrderManagementRefreshed {
  const OrderManagementRefreshed._();
  const factory OrderManagementRefreshed() = _OrderManagementRefreshed;
}
