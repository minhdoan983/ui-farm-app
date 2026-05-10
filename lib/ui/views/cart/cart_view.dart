import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_farm/domain/domain.dart';
import 'package:ui_farm/ui/ui.dart';

@RoutePage()
class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends BasePageState<CartView, CartBloc> {
  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF7EF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        title: const Text(
          'Giỏ hàng',
          style: TextStyle(color: Color(0xFF6B3A1F), fontWeight: FontWeight.w600, fontSize: 16),
        ),
        actions: [
          BlocBuilder<AppBloc, AppState>(
            buildWhen: (p, c) => p.cart.cartItems.length != c.cart.cartItems.length,
            builder: (context, state) => Container(
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.brown,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${state.cart.cartItems.length} sản phẩm',
                style: const TextStyle(color: Colors.white, fontSize: 11),
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<AppBloc, AppState>(
        buildWhen: (p, c) => p.cart != c.cart || p.isLoading != c.isLoading,
        builder: (context, appState) {
          if (appState.isLoading) {
            return const Center(child: CircularProgressIndicator(color: Colors.brown));
          }

          if (appState.cart.cartItems.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.shopping_cart_outlined, size: 60, color: Color(0xFFD4A574)),
                  const SizedBox(height: 12),
                  const Text(
                    'Giỏ hàng trống',
                    style: TextStyle(color: Color(0xFFA07850), fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () => context.router.pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Tiếp tục mua sắm'),
                  ),
                ],
              ),
            );
          }

          final totalPrice = appState.cart.cartItems.fold(
            0,
            (sum, item) => sum + item.price * item.quantity,
          );

          return Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  color: Colors.brown,
                  onRefresh: () async => context.read<AppBloc>().add(const AppCartUpdated()),
                  child: BlocBuilder<CartBloc, CartState>(
                    builder: (context, cartState) => ListView.separated(
                      padding: const EdgeInsets.all(14),
                      itemCount: appState.cart.cartItems.length + 1,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        if (index == appState.cart.cartItems.length) {
                          return _SummaryCard(totalPrice: totalPrice);
                        }
                        final item = appState.cart.cartItems[index];
                        final isItemLoading = cartState.loadingItems[item.itemId] ?? false;
                        return _CartItem(
                          item: item,
                          isLoading: isItemLoading,
                          onRemove: () => bloc.add(CartItemRemovePressed(itemId: item.itemId)),
                          onIncrease: () => bloc.add(
                            CartItemQuantityIncreased(
                              itemId: item.itemId,
                              currentQuantity: item.quantity,
                            ),
                          ),
                          onDecrease: () => bloc.add(
                            CartItemQuantityDecreased(
                              itemId: item.itemId,
                              currentQuantity: item.quantity,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              _CheckoutButton(totalPrice: totalPrice),
            ],
          );
        },
      ),
    );
  }
}

class _CartItem extends StatelessWidget {
  const _CartItem({
    required this.item,
    required this.isLoading,
    required this.onRemove,
    required this.onIncrease,
    required this.onDecrease,
  });

  final CartItem item;
  final bool isLoading;
  final VoidCallback onRemove;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isLoading ? 0.5 : 1.0,
      duration: const Duration(milliseconds: 200),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFEAD8C8)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: item.imgUrl.isNotEmpty
                  ? Image.network(
                      item.imgUrl,
                      width: 72,
                      height: 90,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _placeholder(),
                    )
                  : _placeholder(),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF3D1F0A),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: Color(0xFFD4A574),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          [
                            if (item.colorSelect.isNotEmpty) item.colorSelect,
                            if (item.materialSelect.isNotEmpty) item.materialSelect,
                          ].join(' · '),
                          style: const TextStyle(fontSize: 11, color: Color(0xFFA07850)),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _QtyControl(
                        quantity: item.quantity,
                        isLoading: isLoading,
                        onIncrease: onIncrease,
                        onDecrease: onDecrease,
                      ),
                      Text(
                        _formatPrice(item.price * item.quantity),
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.brown,
                        ),
                      ),
                      GestureDetector(
                        onTap: isLoading ? null : onRemove,
                        child: Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF0E4),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xFFEAD8C8)),
                          ),
                          child: isLoading
                              ? const Padding(
                                  padding: EdgeInsets.all(6),
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.brown,
                                  ),
                                )
                              : const Icon(
                                  Icons.delete_outline_rounded,
                                  size: 14,
                                  color: Color(0xFFC0522A),
                                ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      width: 72,
      height: 90,
      color: const Color(0xFFD4B896),
      child: const Icon(Icons.checkroom_rounded, color: Colors.white54, size: 32),
    );
  }

  String _formatPrice(int price) {
    return '${price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')} đ';
  }
}

class _QtyControl extends StatelessWidget {
  const _QtyControl({
    required this.quantity,
    required this.isLoading,
    required this.onIncrease,
    required this.onDecrease,
  });

  final int quantity;
  final bool isLoading;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFF0E4),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFEAD8C8)),
      ),
      child: Row(
        children: [
          _QtyBtn(label: '−', onTap: isLoading ? null : onDecrease),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              '$quantity',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color(0xFF3D1F0A),
              ),
            ),
          ),
          _QtyBtn(label: '+', onTap: isLoading ? null : onIncrease),
        ],
      ),
    );
  }
}

class _QtyBtn extends StatelessWidget {
  const _QtyBtn({required this.label, required this.onTap});
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 28,
        height: 28,
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: onTap == null ? Colors.brown.withValues(alpha: 0.3) : Colors.brown,
            ),
          ),
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.totalPrice});
  final int totalPrice;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFEAD8C8)),
      ),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 3,
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFEAD8C8),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          _SummaryRow(label: 'Tạm tính', value: _formatPrice(totalPrice)),
          const _SummaryRow(label: 'Phí may đo', value: 'Miễn phí'),
          const _SummaryRow(label: 'Giao hàng', value: '50.000 đ'),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Divider(color: Color(0xFFEAD8C8)),
          ),
          _SummaryRow(label: 'Tổng cộng', value: _formatPrice(totalPrice + 50000), isTotal: true),
        ],
      ),
    );
  }

  String _formatPrice(int price) {
    return '${price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')} đ';
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.value, this.isTotal = false});
  final String label;
  final String value;
  final bool isTotal;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 15 : 13,
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
              color: isTotal ? const Color(0xFF3D1F0A) : const Color(0xFFA07850),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 15 : 13,
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
              color: isTotal ? const Color(0xFF3D1F0A) : const Color(0xFFA07850),
            ),
          ),
        ],
      ),
    );
  }
}

class _CheckoutButton extends StatelessWidget {
  const _CheckoutButton({required this.totalPrice});
  final int totalPrice;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 8, 14, 24),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.brown,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          child: const Text(
            'Thanh toán →',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
