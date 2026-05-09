import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ItemManagementView extends StatefulWidget {
  const ItemManagementView({super.key});

  @override
  State<ItemManagementView> createState() => _ItemManagementViewState();
}

class _ItemManagementViewState extends State<ItemManagementView> {
  int _tabIndex = 0;
  int _selectedColorIndex = 0;
  String? _selectedMaterial;
  String? _selectedGallery;
  final _nameCtrl = TextEditingController();
  final _priceCtrl = TextEditingController();
  final _galleryCtrl = TextEditingController();

  final _colors = [
    Colors.red,
    Colors.black,
    Colors.white,
    Colors.brown,
    Colors.green,
  ];
  final _materials = ['Linen bột', 'Lụa tơ', 'Đũi thô', 'Tuyết mai'];
  final _galleries = ['BST Xuân 2024', 'BST Tết', 'BST Cưới'];

  @override
  void dispose() {
    _nameCtrl.dispose();
    _priceCtrl.dispose();
    _galleryCtrl.dispose();
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
          'Quản lý sản phẩm',
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
            child: Row(
              children: ['Tạo mới', 'Chỉnh sửa', 'Thư viện']
                  .asMap()
                  .entries
                  .map((e) {
                    final selected = _tabIndex == e.key;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _tabIndex = e.key),
                        child: Container(
                          margin: EdgeInsets.only(left: e.key == 0 ? 0 : 6),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: selected ? Colors.brown : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: selected
                                  ? Colors.brown
                                  : const Color(0xFFEAD8C8),
                            ),
                          ),
                          child: Text(
                            e.value,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: selected
                                  ? Colors.white
                                  : const Color(0xFFA07850),
                            ),
                          ),
                        ),
                      ),
                    );
                  })
                  .toList(),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildField(
              'TÊN SẢN PHẨM',
              controller: _nameCtrl,
              hint: 'Nhập tên áo dài...',
            ),
            const SizedBox(height: 12),
            _buildField(
              'GIÁ BÁN',
              controller: _priceCtrl,
              hint: '0 đ',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),

            // Colors
            const Text(
              'MÀU SẮC',
              style: TextStyle(
                fontSize: 11,
                color: Color(0xFFA07850),
                letterSpacing: 0.4,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFEAD8C8)),
              ),
              child: Row(
                children: [
                  ...List.generate(
                    _colors.length,
                    (i) => GestureDetector(
                      onTap: () => setState(() => _selectedColorIndex = i),
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
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFFD4A574),
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: const Icon(
                      Icons.add,
                      size: 14,
                      color: Color(0xFFD4A574),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Material dropdown
            const Text(
              'CHẤT LIỆU',
              style: TextStyle(
                fontSize: 11,
                color: Color(0xFFA07850),
                letterSpacing: 0.4,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFEAD8C8)),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedMaterial,
                  hint: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14),
                    child: Text(
                      'Chọn chất liệu',
                      style: TextStyle(fontSize: 13, color: Color(0xFFC4A882)),
                    ),
                  ),
                  isExpanded: true,
                  borderRadius: BorderRadius.circular(12),
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  items: _materials
                      .map(
                        (m) => DropdownMenuItem(
                          value: m,
                          child: Text(m, style: const TextStyle(fontSize: 13)),
                        ),
                      )
                      .toList(),
                  onChanged: (v) => setState(() => _selectedMaterial = v),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Divider(color: Color(0xFFEAD8C8)),
            const SizedBox(height: 12),

            // Images
            Row(
              children: [
                const Icon(Icons.photo_outlined, size: 16, color: Colors.brown),
                const SizedBox(width: 6),
                const Text(
                  'Hình ảnh sản phẩm',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF3D1F0A),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {}, // TODO: image picker
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 24),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFAF5),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: const Color(0xFFD4A574),
                    style: BorderStyle.solid,
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5E6D4),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.cloud_upload_outlined,
                        color: Colors.brown,
                        size: 20,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Nhấn để tải ảnh lên',
                      style: TextStyle(fontSize: 12, color: Color(0xFFA07850)),
                    ),
                    const Text(
                      'PNG, JPG tối đa 5MB',
                      style: TextStyle(fontSize: 10, color: Color(0xFFC4A882)),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Divider(color: Color(0xFFEAD8C8)),
            const SizedBox(height: 12),

            // Gallery
            Row(
              children: [
                const Icon(
                  Icons.grid_view_rounded,
                  size: 16,
                  color: Colors.brown,
                ),
                const SizedBox(width: 6),
                const Text(
                  'Thư viện ảnh',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF3D1F0A),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'CHỌN THƯ VIỆN',
              style: TextStyle(
                fontSize: 11,
                color: Color(0xFFA07850),
                letterSpacing: 0.4,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFEAD8C8)),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedGallery,
                  hint: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14),
                    child: Text(
                      'Chọn thư viện',
                      style: TextStyle(fontSize: 13, color: Color(0xFFC4A882)),
                    ),
                  ),
                  isExpanded: true,
                  borderRadius: BorderRadius.circular(12),
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  items: _galleries
                      .map(
                        (g) => DropdownMenuItem(
                          value: g,
                          child: Text(g, style: const TextStyle(fontSize: 13)),
                        ),
                      )
                      .toList(),
                  onChanged: (v) => setState(() => _selectedGallery = v),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.brown,
                      side: const BorderSide(color: Colors.brown),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      '+ Thêm vào thư viện',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFFC0522A),
                      side: const BorderSide(color: Color(0xFFC0522A)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Xoá thư viện',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            _buildField(
              'TẠO THƯ VIỆN MỚI',
              controller: _galleryCtrl,
              hint: 'Tên thư viện...',
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8B5E3C),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text('Tạo thư viện'),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6B3A1F),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Tạo sản phẩm →',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildField(
    String label, {
    required TextEditingController controller,
    String? hint,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: Color(0xFFA07850),
            letterSpacing: 0.4,
          ),
        ),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          style: const TextStyle(fontSize: 13, color: Color(0xFF3D1F0A)),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Color(0xFFC4A882), fontSize: 13),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 10,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFEAD8C8)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFEAD8C8)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.brown),
            ),
          ),
        ),
      ],
    );
  }
}
