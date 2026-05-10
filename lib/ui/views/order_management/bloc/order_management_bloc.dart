import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart' hide Order;
import 'package:ui_farm/domain/domain.dart';
import 'package:ui_farm/shared/shared.dart';
import 'package:ui_farm/ui/ui.dart';

part 'order_management_event.dart';
part 'order_management_state.dart';
part 'order_management_bloc.freezed.dart';

@injectable
class OrderManagementBloc extends BaseBloc<OrderManagementEvent, OrderManagementState> {
  OrderManagementBloc(this._getOrdersUseCase) : super(const OrderManagementState()) {
    on<OrderManagementViewInitiated>(_onViewInitiated);
    on<OrderManagementRefreshed>(_onRefreshed);
  }

  final GetOrdersUseCase _getOrdersUseCase;

  FutureOr<void> _onViewInitiated(
    OrderManagementViewInitiated event,
    Emitter<OrderManagementState> emit,
  ) async {
    await _fetchOrders(emit);
  }

  FutureOr<void> _onRefreshed(
    OrderManagementRefreshed event,
    Emitter<OrderManagementState> emit,
  ) async {
    await _fetchOrders(emit);
  }

  Future<void> _fetchOrders(Emitter<OrderManagementState> emit) async {
    await runBlocCatching(
      doOnSubscribe: () async => emit(state.copyWith(isLoading: true)),
      doOnSuccessOrError: () async => emit(state.copyWith(isLoading: false)),
      action: () async {
        final output = await _getOrdersUseCase.execute(const GetOrdersInput());
        emit(state.copyWith(orders: output.orders));
      },
      doOnError: (error) async {
        final message = error is RemoteException ? error.generalMessage : 'Không thể tải đơn hàng';
        emit(state.copyWith(errorMessage: message));
      },
    );
  }
}
