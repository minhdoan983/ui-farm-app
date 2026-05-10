import 'package:injectable/injectable.dart';
import 'package:ui_farm/data/data.dart';
import 'package:ui_farm/domain/domain.dart';

@injectable
class CartDataMapper extends BaseDataMapper<CartData, Cart> {
  const CartDataMapper(this._itemList);

  final List<Item> _itemList;

  @override
  Cart mapToEntity(CartData? data) {
    return Cart(
      id: data?.id ?? '',
      userId: data?.user ?? '',
      isActive: data?.isActive ?? false,
      cartItems:
          data?.cartItems?.map((e) {
            final item = _itemList.firstWhere((i) => i.id == e.itemId, orElse: () => const Item());
            return CartItem(
              id: e.id ?? '',
              itemId: e.itemId ?? '',
              quantity: e.quantity ?? 0,
              price: e.price ?? 0,
              materialSelect: e.materialSelect ?? '',
              colorSelect: e.colorSelect ?? '',
              name: item.name,
              imgUrl: item.imgUrl.isNotEmpty ? item.imgUrl.first : '',
            );
          }).toList() ??
          [],
    );
  }
}
