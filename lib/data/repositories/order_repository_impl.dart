import 'package:injectable/injectable.dart' hide Order;
import 'package:ui_farm/data/data.dart';
import 'package:ui_farm/domain/domain.dart';

@LazySingleton(as: OrderRepository)
class OrderRepositoryImpl implements OrderRepository {
  const OrderRepositoryImpl(this._appApiService, this._orderDataMapper);

  final AppApiService _appApiService;
  final OrderDataMapper _orderDataMapper;

  @override
  Future<List<Order>> getOrders() async {
    final response = await _appApiService.getOrders();
    return _orderDataMapper.mapToEntityList(response);
  }
}
