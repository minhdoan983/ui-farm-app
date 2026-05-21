import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_farm/domain/domain.dart';
import 'package:ui_farm/shared/shared.dart';
import 'package:ui_farm/ui/ui.dart';

@RoutePage()
class OrderManagementView extends StatefulWidget {
  const OrderManagementView({super.key});

  @override
  State<OrderManagementView> createState() => _OrderManagementViewState();
}

class _OrderManagementViewState extends BasePageState<OrderManagementView, OrderManagementBloc>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final _tabs = ['Tất cả', 'Chờ xử lý', 'Đã duyệt'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    bloc.add(const OrderManagementViewInitiated());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF7EF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          'Quản lý đơn hàng',
          style: TextStyle(color: Color(0xFF6B3A1F), fontWeight: FontWeight.w600, fontSize: 16),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(52),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 0, 14, 10),
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              dividerColor: Colors.transparent,
              indicator: BoxDecoration(
                color: Colors.brown,
                borderRadius: BorderRadius.circular(10),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: Colors.white,
              unselectedLabelColor: const Color(0xFFA07850),
              labelStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
              tabs: _tabs
                  .map(
                    (t) => Tab(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Text(t),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
      body: BlocBuilder<OrderManagementBloc, OrderManagementState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator(color: Colors.brown));
          }

          if (state.errorMessage.isNotEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.errorMessage),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () => bloc.add(const OrderManagementRefreshed()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Thử lại'),
                  ),
                ],
              ),
            );
          }

          return TabBarView(
            controller: _tabController,
            children: [
              _OrderList(
                orders: state.orders,
                onRefresh: () => bloc.add(const OrderManagementRefreshed()),
              ),
              _OrderList(
                orders: state.pendingOrders,
                onRefresh: () => bloc.add(const OrderManagementRefreshed()),
              ),
              _OrderList(
                orders: state.approvedOrders,
                onRefresh: () => bloc.add(const OrderManagementRefreshed()),
              ),
              _OrderList(
                orders: state.cancelledOrders,
                onRefresh: () => bloc.add(const OrderManagementRefreshed()),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _OrderList extends StatelessWidget {
  const _OrderList({required this.orders, required this.onRefresh});
  final List<Order> orders;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      return const Center(
        child: Text('Không có đơn hàng', style: TextStyle(color: Color(0xFFA07850))),
      );
    }

    return RefreshIndicator(
      color: Colors.brown,
      onRefresh: () async => onRefresh(),
      child: ListView.separated(
        padding: const EdgeInsets.all(14),
        itemCount: orders.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (_, i) => _OrderCard(order: orders[i]),
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  const _OrderCard({required this.order});
  final Order order;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFEAD8C8)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '#${order.id.substring(order.id.length > 8 ? order.id.length - 8 : 0)}',
                    style: const TextStyle(fontSize: 11, color: Color(0xFFA07850)),
                  ),
                ),
                _StatusBadge(status: order.status),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFEAD8C8)),

          // Items
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: order.items
                  .map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: item.imgUrl.isNotEmpty
                                ? Image.network(
                                    item.imgUrl,
                                    width: 44,
                                    height: 54,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => _placeholder(),
                                  )
                                : _placeholder(),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF3D1F0A),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  [
                                    if (item.colorSelect.isNotEmpty) item.colorSelect,
                                    if (item.materialSelect.isNotEmpty) item.materialSelect,
                                    'SL: ${item.quantity}',
                                  ].join(' · '),
                                  style: const TextStyle(fontSize: 10, color: Color(0xFFA07850)),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            (item.price * item.quantity).toFormattedPrice(),
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.brown,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: const BoxDecoration(
              color: Color(0xFFFFFAF6),
              border: Border(top: BorderSide(color: Color(0xFFEAD8C8))),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(18)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Tổng đơn hàng',
                  style: TextStyle(fontSize: 11, color: Color(0xFFA07850)),
                ),
                Text(
                  order.totalPrice.toFormattedPrice(),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF3D1F0A),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      width: 44,
      height: 54,
      decoration: BoxDecoration(
        color: const Color(0xFFD4B896),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Icon(Icons.checkroom_rounded, color: Colors.white54, size: 20),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});
  final OrderStatus status;

  @override
  Widget build(BuildContext context) {
    final (label, bg, fg) = switch (status) {
      OrderStatus.approved => ('Đã duyệt', const Color(0xFFEAF3DE), const Color(0xFF3B6D11)),
      OrderStatus.cancelled => ('Đã huỷ', const Color(0xFFFDECEC), const Color(0xFFC0522A)),
      OrderStatus.pending => ('Chờ xử lý', const Color(0xFFFAEEDA), const Color(0xFF854F0B)),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
      child: Text(
        label,
        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: fg),
      ),
    );
  }
}
