import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ui_farm/resources/resources.dart';

@RoutePage()
class ItemDetailView extends StatefulWidget {
  const ItemDetailView({super.key});

  @override
  State<ItemDetailView> createState() => _ItemDetailViewState();
}

class _ItemDetailViewState extends State<ItemDetailView> {
  int _selectedColorIndex = 0;
  int _selectedMaterialIndex = 0;
  int _quantity = 1;
  int _selectedThumbIndex = 0;

  final _colors = [
    Colors.red,
    Colors.black,
    Colors.white,
    Colors.brown,
    Colors.green,
  ];
  final _materials = ['Linen bột', 'Lụa tơ', 'Đũi thô', 'Tuyết mai'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF7EF),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Hero image
                  Stack(
                    children: [
                      SizedBox(
                        height: 380,
                        width: double.infinity,
                        child: Assets.images.shirt1.image(fit: BoxFit.cover),
                      ),
                      SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _CircleBtn(
                                icon: Icons.arrow_back_ios_new_rounded,
                                onTap: () => context.router.pop(),
                              ),
                              _CircleBtn(
                                icon: Icons.favorite_border_rounded,
                                color: const Color(0xFFC0522A),
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Thumbnails
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          5,
                          (i) => GestureDetector(
                            onTap: () =>
                                setState(() => _selectedThumbIndex = i),
                            child: Container(
                              width: 52,
                              height: 64,
                              margin: const EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: _selectedThumbIndex == i
                                      ? Colors.brown
                                      : Colors.transparent,
                                  width: 1.5,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(9),
                                child: Assets.images.shirt1.image(
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Info
                  Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Expanded(
                              child: Text(
                                'Áo dài Hoa súng bìm bìm',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF3D1F0A),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.brown,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                '7.610.000 đ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Colors
                        const Text(
                          'MÀU SẮC',
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFFA07850),
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: List.generate(
                            _colors.length,
                            (i) => GestureDetector(
                              onTap: () =>
                                  setState(() => _selectedColorIndex = i),
                              child: Container(
                                width: 28,
                                height: 28,
                                margin: const EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: _selectedColorIndex == i
                                        ? Colors.brown
                                        : Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(3),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: _colors[i],
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.black12),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Materials
                        const Text(
                          'CHẤT LIỆU',
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFFA07850),
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: List.generate(
                            _materials.length,
                            (i) => GestureDetector(
                              onTap: () =>
                                  setState(() => _selectedMaterialIndex = i),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: _selectedMaterialIndex == i
                                      ? Colors.brown
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: _selectedMaterialIndex == i
                                        ? Colors.brown
                                        : const Color(0xFFEAD8C8),
                                  ),
                                ),
                                child: Text(
                                  _materials[i],
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: _selectedMaterialIndex == i
                                        ? Colors.white
                                        : const Color(0xFF8B5E3C),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Quantity
                        Row(
                          children: [
                            const Text(
                              'SỐ LƯỢNG',
                              style: TextStyle(
                                fontSize: 11,
                                color: Color(0xFFA07850),
                                letterSpacing: 0.5,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFF0E4),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: const Color(0xFFEAD8C8),
                                ),
                              ),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      if (_quantity > 1)
                                        setState(() => _quantity--);
                                    },
                                    child: const SizedBox(
                                      width: 36,
                                      height: 36,
                                      child: Center(
                                        child: Text(
                                          '−',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.brown,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '$_quantity',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF3D1F0A),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () => setState(() => _quantity++),
                                    child: const SizedBox(
                                      width: 36,
                                      height: 36,
                                      child: Center(
                                        child: Text(
                                          '+',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.brown,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
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
          ),

          // Bottom actions
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 8, 14, 24),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.shopping_cart_outlined, size: 16),
                    label: const Text('Thêm giỏ'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.brown,
                      side: const BorderSide(color: Colors.brown, width: 1.5),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
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
                    child: const Text('Mua ngay →'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleBtn extends StatelessWidget {
  const _CircleBtn({required this.icon, required this.onTap, this.color});
  final IconData icon;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, size: 18, color: color ?? Colors.brown),
      ),
    );
  }
}
