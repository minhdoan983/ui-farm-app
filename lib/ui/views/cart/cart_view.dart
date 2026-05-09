import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF7EF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.brown,
          ),
          onPressed: () => context.router.pop(),
        ),
        title: const Text(
          'Giỏ hàng',
          style: TextStyle(
            color: Color(0xFF6B3A1F),
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.brown,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              '3 sản phẩm',
              style: TextStyle(color: Colors.white, fontSize: 11),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(14),
              children: const [
                _CartItem(
                  name: 'Áo dài Cành tùng bản đồ',
                  variant: 'Size M · Màu trắng ngà',
                  price: 2660000,
                  quantity: 1,
                ),
                SizedBox(height: 10),
                _CartItem(
                  name: 'Áo dài Tuyết mai bình đào',
                  variant: 'Size S · Màu kem',
                  price: 1885000,
                  quantity: 1,
                ),
                SizedBox(height: 10),
                _CartItem(
                  name: 'Áo dài Hướng dương thêu chữ',
                  variant: 'Size L · Màu vàng nhạt',
                  price: 3415000,
                  quantity: 2,
                ),
                SizedBox(height: 14),
                _SummaryCard(),
              ],
            ),
          ),
          _CheckoutButton(),
        ],
      ),
    );
  }
}

class _CartItem extends StatelessWidget {
  const _CartItem({
    required this.name,
    required this.variant,
    required this.price,
    required this.quantity,
  });

  final String name;
  final String variant;
  final int price;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            child: Container(
              width: 72,
              height: 90,
              color: const Color(0xFFD4B896),
              child: const Icon(
                Icons.checkroom_rounded,
                color: Colors.white54,
                size: 32,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
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
                    Text(
                      variant,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFFA07850),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _QtyControl(quantity: quantity),
                    Text(
                      '${(price * quantity / 1000).toStringAsFixed(0)}.000 đ',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.brown,
                      ),
                    ),
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF0E4),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFEAD8C8)),
                      ),
                      child: const Icon(
                        Icons.delete_outline_rounded,
                        size: 14,
                        color: Color(0xFFC0522A),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QtyControl extends StatelessWidget {
  const _QtyControl({required this.quantity});
  final int quantity;

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
          _QtyBtn(label: '−', onTap: () {}),
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
          _QtyBtn(label: '+', onTap: () {}),
        ],
      ),
    );
  }
}

class _QtyBtn extends StatelessWidget {
  const _QtyBtn({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

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
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.brown,
            ),
          ),
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard();

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
          _SummaryRow(label: 'Tạm tính', value: '7.960.000 đ'),
          _SummaryRow(label: 'Phí may đo', value: 'Miễn phí'),
          _SummaryRow(label: 'Giao hàng', value: '50.000 đ'),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Divider(color: Color(0xFFEAD8C8)),
          ),
          _SummaryRow(label: 'Tổng cộng', value: '11.375.000 đ', isTotal: true),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.isTotal = false,
  });
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
              color: isTotal
                  ? const Color(0xFF3D1F0A)
                  : const Color(0xFFA07850),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 15 : 13,
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
              color: isTotal
                  ? const Color(0xFF3D1F0A)
                  : const Color(0xFFA07850),
            ),
          ),
        ],
      ),
    );
  }
}

class _CheckoutButton extends StatelessWidget {
  const _CheckoutButton();

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
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
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
