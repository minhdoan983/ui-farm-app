import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:ui_farm/di/injection.dart';
import 'package:ui_farm/domain/domain.dart';
import 'package:ui_farm/shared/shared.dart';
import 'package:ui_farm/ui/ui.dart';

part 'cart_event.dart';
part 'cart_state.dart';
part 'cart_bloc.freezed.dart';

@injectable
class CartBloc extends BaseBloc<CartEvent, CartState> {
  CartBloc(this._removeCartItemUseCase, this._updateCartQuantityUseCase)
    : super(const CartState()) {
    on<CartItemRemovePressed>(_onItemRemovePressed);
    on<CartItemQuantityIncreased>(_onQuantityIncreased);
    on<CartItemQuantityDecreased>(_onQuantityDecreased);
  }

  final RemoveCartItemUseCase _removeCartItemUseCase;
  final UpdateCartQuantityUseCase _updateCartQuantityUseCase;

  String get _userId => getIt<AppBloc>().state.user.id;

  FutureOr<void> _onItemRemovePressed(CartItemRemovePressed event, Emitter<CartState> emit) async {
    emit(state.copyWith(loadingItems: {...state.loadingItems, event.itemId: true}));

    await runBlocCatching(
      action: () async {
        await _removeCartItemUseCase.execute(
          RemoveCartItemInput(userId: _userId, itemId: event.itemId),
        );
        getIt<AppBloc>().add(const AppCartUpdated());
      },
      doOnError: (error) async {
        final message = error is RemoteException ? error.generalMessage : 'Không thể xóa sản phẩm';
        emit(state.copyWith(errorMessage: message));
      },
      doOnSuccessOrError: () async {
        final updated = Map<String, bool>.from(state.loadingItems)..remove(event.itemId);
        emit(state.copyWith(loadingItems: updated));
      },
    );
  }

  FutureOr<void> _onQuantityIncreased(
    CartItemQuantityIncreased event,
    Emitter<CartState> emit,
  ) async {
    final newQty = event.currentQuantity + 1;
    await _updateQuantity(emit, itemId: event.itemId, quantity: newQty);
  }

  FutureOr<void> _onQuantityDecreased(
    CartItemQuantityDecreased event,
    Emitter<CartState> emit,
  ) async {
    if (event.currentQuantity <= 1) {
      add(CartItemRemovePressed(itemId: event.itemId));
      return;
    }
    final newQty = event.currentQuantity - 1;
    await _updateQuantity(emit, itemId: event.itemId, quantity: newQty);
  }

  Future<void> _updateQuantity(
    Emitter<CartState> emit, {
    required String itemId,
    required int quantity,
  }) async {
    emit(state.copyWith(loadingItems: {...state.loadingItems, itemId: true}));

    await runBlocCatching(
      action: () async {
        await _updateCartQuantityUseCase.execute(
          UpdateCartQuantityInput(userId: _userId, itemId: itemId, quantity: quantity),
        );
        getIt<AppBloc>().add(const AppCartUpdated());
      },
      doOnError: (error) async {
        final message = error is RemoteException
            ? error.generalMessage
            : 'Không thể cập nhật số lượng';
        emit(state.copyWith(errorMessage: message));
      },
      doOnSuccessOrError: () async {
        final updated = Map<String, bool>.from(state.loadingItems)..remove(itemId);
        emit(state.copyWith(loadingItems: updated));
      },
    );
  }
}
