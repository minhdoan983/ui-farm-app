import 'package:injectable/injectable.dart';
import 'package:ui_farm/data/data.dart';
import 'package:ui_farm/domain/domain.dart';

@LazySingleton(as: CartRepository)
class CartRepositoryImpl implements CartRepository {
  const CartRepositoryImpl(this._appApiService);

  final AppApiService _appApiService;

  @override
  Future<Cart> getCart({required String userId}) async {
    final response = await _appApiService.getCart(userId: userId);
    return Cart(
      id: response?.id ?? '',
      userId: response?.user ?? '',
      isActive: response?.isActive ?? false,
      cartItems:
          response?.cartItems
              ?.map(
                (e) => CartItem(
                  id: e.id ?? '',
                  itemId: e.itemId ?? '',
                  quantity: e.quantity ?? 0,
                  price: e.price ?? 0,
                  materialSelect: e.materialSelect ?? '',
                  colorSelect: e.colorSelect ?? '',
                ),
              )
              .toList() ??
          [],
    );
  }

  @override
  Future<void> removeCartItem({required String userId, required String itemId}) async {
    await _appApiService.removeCartItem(userId: userId, itemId: itemId);
  }

  @override
  Future<void> updateCartQuantity({
    required String userId,
    required String itemId,
    required int quantity,
  }) async {
    await _appApiService.updateCartQuantity(userId: userId, itemId: itemId, quantity: quantity);
  }
}
