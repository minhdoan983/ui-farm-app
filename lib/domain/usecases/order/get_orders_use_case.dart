import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart' hide Order;
import 'package:ui_farm/domain/domain.dart';

part 'get_orders_use_case.freezed.dart';

@injectable
class GetOrdersUseCase extends BaseFutureUseCase<GetOrdersInput, GetOrdersOutput> {
  const GetOrdersUseCase(this._orderRepository);

  final OrderRepository _orderRepository;

  @override
  Future<GetOrdersOutput> buildUseCase(GetOrdersInput input) async {
    final orders = await _orderRepository.getOrders();
    return GetOrdersOutput(orders: orders);
  }
}

@freezed
sealed class GetOrdersInput extends BaseInput with _$GetOrdersInput {
  const GetOrdersInput._();
  const factory GetOrdersInput() = _GetOrdersInput;
}

@freezed
sealed class GetOrdersOutput extends BaseOutput with _$GetOrdersOutput {
  const GetOrdersOutput._();
  const factory GetOrdersOutput({@Default([]) List<Order> orders}) = _GetOrdersOutput;
}
