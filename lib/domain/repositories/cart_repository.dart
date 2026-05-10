import 'package:ui_farm/domain/domain.dart';

abstract class CartRepository {
  Future<Cart> getCart({required String userId});
  Future<void> removeCartItem({required String userId, required String itemId});
  Future<void> updateCartQuantity({
    required String userId,
    required String itemId,
    required int quantity,
  });
}
