import 'package:injectable/injectable.dart' hide Order;
import 'package:ui_farm/data/data.dart';
import 'package:ui_farm/domain/domain.dart';

@injectable
class OrderDataMapper extends BaseDataMapper<OrderData, Order> {
  const OrderDataMapper();

  @override
  Order mapToEntity(OrderData? data) {
    return Order(
      id: data?.id ?? '',
      paypalOrderID: data?.paypalOrderID ?? '',
      createdAt: data?.createdAt ?? '',
      status: _mapStatus(data?.status),
      items: data?.cartId?.cartItems?.map(_mapItem).toList() ?? [],
    );
  }

  List<Order> mapToEntityList(List<OrderData>? dataList) {
    return dataList?.map(mapToEntity).toList() ?? [];
  }

  OrderItem _mapItem(OrderCartItemData e) {
    final item = e.itemId;
    return OrderItem(
      id: e.id ?? '',
      itemId: item?.id ?? '',
      name: item?.name ?? '',
      imgUrl: item?.imgUrl?.isNotEmpty == true ? item!.imgUrl!.first : '',
      quantity: e.quantity ?? 0,
      price: e.price ?? 0,
      materialSelect: e.materialSelect ?? '',
      colorSelect: e.colorSelect ?? '',
    );
  }

  OrderStatus _mapStatus(String? status) {
    return switch (status?.toLowerCase()) {
      'approved' => OrderStatus.approved,
      'cancelled' => OrderStatus.cancelled,
      'canceled' => OrderStatus.cancelled,
      _ => OrderStatus.pending,
    };
  }
}
