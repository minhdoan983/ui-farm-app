import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:ui_farm/domain/domain.dart';
import 'package:ui_farm/ui/ui.dart';

part 'app_event.dart';
part 'app_state.dart';
part 'app_bloc.freezed.dart';

@lazySingleton
class AppBloc extends BaseBloc<AppEvent, AppState> {
  AppBloc(this._getItemsUseCase, this._checkAuthUseCase, this._getMeUseCase, this._getCartUseCase)
    : super(const AppState()) {
    on<AppStarted>(_onAppStarted);
    on<AppUserUpdated>(_onUserUpdated);
    on<AppCartUpdated>(_onCartUpdated);
  }

  final GetItemsUseCase _getItemsUseCase;
  final CheckAuthUseCase _checkAuthUseCase;
  final GetMeUseCase _getMeUseCase;
  final GetCartUseCase _getCartUseCase;

  FutureOr<void> _onAppStarted(AppStarted event, Emitter<AppState> emit) async {
    await runBlocCatching(
      doOnSubscribe: () async => emit(state.copyWith(isLoading: true)),
      doOnSuccessOrError: () async => emit(state.copyWith(isLoading: false)),
      action: () async {
        final results = await Future.wait([
          _checkAuthUseCase.execute(const CheckAuthInput()),
          _getItemsUseCase.execute(const GetItemsInput()),
        ]);

        final authOutput = results[0] as CheckAuthOutput;
        final itemsOutput = results[1] as GetItemsOutput;

        User user = const User();
        Cart cart = const Cart();

        if (authOutput.isAuthenticated) {
          final meOutput = await _getMeUseCase.execute(const GetMeInput());
          user = meOutput.user;

          final cartOutput = await _getCartUseCase.execute(GetCartInput(userId: user.id));
          cart = _mapCartWithItems(cartOutput.cart, itemsOutput.items);
        }

        emit(
          state.copyWith(
            isAuthenticated: authOutput.isAuthenticated,
            items: itemsOutput.items,
            user: user,
            cart: cart,
          ),
        );
      },
    );
  }

  FutureOr<void> _onUserUpdated(AppUserUpdated event, Emitter<AppState> emit) {
    emit(state.copyWith(user: event.user, isAuthenticated: true));
  }

  FutureOr<void> _onCartUpdated(AppCartUpdated event, Emitter<AppState> emit) async {
    await runBlocCatching(
      action: () async {
        final cartOutput = await _getCartUseCase.execute(GetCartInput(userId: state.user.id));
        final cart = _mapCartWithItems(cartOutput.cart, state.items);
        emit(state.copyWith(cart: cart));
      },
    );
  }

  Cart _mapCartWithItems(Cart cart, List<Item> items) {
    final cartItemsWithInfo = cart.cartItems.map((cartItem) {
      final item = items.firstWhere((i) => i.id == cartItem.itemId, orElse: () => const Item());
      return cartItem.copyWith(
        name: item.name,
        imgUrl: item.imgUrl.isNotEmpty ? item.imgUrl.first : '',
      );
    }).toList();

    return cart.copyWith(cartItems: cartItemsWithInfo);
  }
}
