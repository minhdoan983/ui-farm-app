import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class OrderManagementView extends StatefulWidget {
  const OrderManagementView({super.key});

  @override
  State<OrderManagementView> createState() => _OrderManagementViewState();
}

class _OrderManagementViewState extends State<OrderManagementView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final _tabs = ['Tất cả', 'Chờ xử lý', 'Đang giao', 'Hoàn thành'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF7EF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.brown,
          ),
          onPressed: () => context.router.pop(),
        ),
        title: const Text(
          'Quản lý đơn hàng',
          style: TextStyle(
            color: Color(0xFF6B3A1F),
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
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
              labelStyle: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
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
      body: TabBarView(
        controller: _tabController,
        children: [
          _OrderList(filter: null),
          _OrderList(filter: OrderStatus.pending),
          _OrderList(filter: OrderStatus.shipping),
          _OrderList(filter: OrderStatus.done),
        ],
      ),
    );
  }
}

enum OrderStatus { pending, shipping, done }

class _OrderList extends StatelessWidget {
  const _OrderList({required this.filter});
  final OrderStatus? filter;

  static final _mockOrders = [
    _OrderData(
      id: '#670a2ee7...464b8',
      status: OrderStatus.done,
      total: '11.375.000 đ',
      items: [
        _OrderItemData(
          name: 'Áo dài Cành tùng bản đồ',
          meta: 'Size M · SL: 1',
          price: '2.660.000 đ',
        ),
        _OrderItemData(
          name: 'Áo dài Hướng dương thêu chữ',
          meta: 'Size L · SL: 2',
          price: '3.415.000 đ',
        ),
      ],
    ),
    _OrderData(
      id: '#670fe6c9...f89f4f',
      status: OrderStatus.shipping,
      total: '1.885.000 đ',
      items: [
        _OrderItemData(
          name: 'Áo dài Tuyết mai bình đào',
          meta: 'Size S · SL: 1',
          price: '1.885.000 đ',
        ),
      ],
    ),
    _OrderData(
      id: '#671abc12...3d9e7f',
      status: OrderStatus.pending,
      total: '3.200.000 đ',
      items: [
        _OrderItemData(
          name: 'Áo dài Muống xanh lụa tơ',
          meta: 'Size M · SL: 1',
          price: '3.200.000 đ',
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final orders = filter == null
        ? _mockOrders
        : _mockOrders.where((o) => o.status == filter).toList();

    if (orders.isEmpty) {
      return const Center(
        child: Text(
          'Không có đơn hàng',
          style: TextStyle(color: Color(0xFFA07850)),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(14),
      itemCount: orders.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (_, i) => _OrderCard(order: orders[i]),
    );
  }
}

class _OrderCard extends StatelessWidget {
  const _OrderCard({required this.order});
  final _OrderData order;

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
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                Text(
                  order.id,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFFA07850),
                  ),
                ),
                const Spacer(),
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
                          Container(
                            width: 44,
                            height: 54,
                            decoration: BoxDecoration(
                              color: const Color(0xFFD4B896),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.checkroom_rounded,
                              color: Colors.white54,
                              size: 20,
                            ),
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
                                Text(
                                  item.meta,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Color(0xFFA07850),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            item.price,
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
          // Footer
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: const BoxDecoration(
              color: Color(0xFFFFFAF6),
              border: Border(top: BorderSide(color: Color(0xFFEAD8C8))),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(18)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tổng đơn hàng',
                      style: TextStyle(fontSize: 11, color: Color(0xFFA07850)),
                    ),
                    Text(
                      order.total,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF3D1F0A),
                      ),
                    ),
                  ],
                ),
                _ActionButton(status: order.status),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});
  final OrderStatus status;

  @override
  Widget build(BuildContext context) {
    final (label, bg, fg) = switch (status) {
      OrderStatus.done => (
        'Đã thanh toán',
        const Color(0xFFEAF3DE),
        const Color(0xFF3B6D11),
      ),
      OrderStatus.shipping => (
        'Đang vận chuyển',
        const Color(0xFFE6F1FB),
        const Color(0xFF185FA5),
      ),
      OrderStatus.pending => (
        'Chờ xử lý',
        const Color(0xFFFAEEDA),
        const Color(0xFF854F0B),
      ),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: fg),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({required this.status});
  final OrderStatus status;

  @override
  Widget build(BuildContext context) {
    final label = switch (status) {
      OrderStatus.done => 'Đặt lại →',
      OrderStatus.shipping => 'Theo dõi →',
      OrderStatus.pending => 'Huỷ đơn',
    };
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.brown),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 11, color: Colors.brown),
        ),
      ),
    );
  }
}

// Data models
class _OrderData {
  const _OrderData({
    required this.id,
    required this.status,
    required this.total,
    required this.items,
  });
  final String id;
  final OrderStatus status;
  final String total;
  final List<_OrderItemData> items;
}

class _OrderItemData {
  const _OrderItemData({
    required this.name,
    required this.meta,
    required this.price,
  });
  final String name;
  final String meta;
  final String price;
}
