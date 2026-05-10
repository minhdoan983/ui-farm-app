import 'package:ui_farm/domain/domain.dart';

abstract class OrderRepository {
  Future<List<Order>> getOrders();
}
