import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_farm/di/injection.dart';
import 'package:ui_farm/domain/domain.dart';
import 'package:ui_farm/ui/ui.dart';

@RoutePage()
class ListItemView extends StatefulWidget {
  const ListItemView({super.key});

  @override
  State<ListItemView> createState() => _ListItemViewState();
}

class _ListItemViewState extends BasePageState<ListItemView, ListItemBloc> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    bloc.add(const ListItemViewInitiated());
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      bloc.add(const ListItemLoadMore());
    }
  }

  void _openAllFilters() => _scaffoldKey.currentState?.openDrawer();

  @override
  Widget buildPage(BuildContext context) {
    return BlocBuilder<ListItemBloc, ListItemState>(
      buildWhen: (p, c) => p.galleries != c.galleries,
      builder: (context, state) {
        return Scaffold(
          key: _scaffoldKey,
          drawer: _buildFilterDrawer(context, state),
          body: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 12, left: 18, right: 18),
                  child: _FilterBar(
                    onTapAll: _openAllFilters,
                    galleries: state.galleries,
                    onTapGallery: (gallery) =>
                        bloc.add(ListItemFilterApplied(galleryName: gallery.name)),
                    selectedGalleryName: state.selectedGalleryName,
                  ),
                ),
              ),
              BlocBuilder<ListItemBloc, ListItemState>(
                buildWhen: (p, c) => p.items != c.items || p.isLoading != c.isLoading,
                builder: (context, state) {
                  if (state.isLoading) {
                    return const SliverFillRemaining(
                      child: Center(child: CircularProgressIndicator(color: Colors.brown)),
                    );
                  }

                  if (state.items.isEmpty) {
                    return const SliverFillRemaining(
                      child: Center(
                        child: Text(
                          'Không tìm thấy sản phẩm',
                          style: TextStyle(color: Color(0xFFA07850)),
                        ),
                      ),
                    );
                  }

                  return SliverPadding(
                    padding: const EdgeInsets.fromLTRB(18, 12, 18, 0),
                    sliver: SliverGrid(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 20,
                        childAspectRatio: 0.65,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => _ItemCard(item: state.items[index]),
                        childCount: state.items.length,
                      ),
                    ),
                  );
                },
              ),

              // Load more indicator
              BlocBuilder<ListItemBloc, ListItemState>(
                buildWhen: (p, c) =>
                    p.isLoadingMore != c.isLoadingMore || p.hasReachedMax != c.hasReachedMax,
                builder: (context, state) {
                  if (state.hasReachedMax) {
                    return const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(
                          child: Text(
                            'Đã hiển thị tất cả sản phẩm',
                            style: TextStyle(color: Color(0xFFA07850), fontSize: 12),
                          ),
                        ),
                      ),
                    );
                  }
                  if (state.isLoadingMore) {
                    return const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(child: CircularProgressIndicator(color: Colors.brown)),
                      ),
                    );
                  }
                  return const SliverToBoxAdapter(child: SizedBox(height: 16));
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterDrawer(BuildContext context, ListItemState state) {
    String? tempColor = state.selectedColor;
    String? tempGalleryName = state.selectedGalleryName;
    int? tempMinPrice = state.minPrice;
    int? tempMaxPrice = state.maxPrice;

    final minPriceCtrl = TextEditingController(text: state.minPrice?.toString() ?? '');
    final maxPriceCtrl = TextEditingController(text: state.maxPrice?.toString() ?? '');

    // lấy tất cả màu từ AppBloc items (đầy đủ hơn là từ filtered items)
    final colors = getIt<AppBloc>().state.items.expand((item) => item.color).toSet().toList()
      ..sort();

    return Drawer(
      child: SafeArea(
        child: StatefulBuilder(
          builder: (context, setDrawerState) {
            return Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Bộ lọc',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close, size: 20),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
                    children: [
                      // Gallery
                      const _FilterSectionTitle('Bộ sưu tập'),
                      // Option "Tất cả"
                      RadioListTile<String?>(
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Tất cả'),
                        value: null,
                        groupValue: tempGalleryName,
                        activeColor: Colors.brown,
                        onChanged: (_) => setDrawerState(() => tempGalleryName = null),
                      ),
                      ...state.galleries.map(
                        (gallery) => RadioListTile<String?>(
                          contentPadding: EdgeInsets.zero,
                          title: Text(gallery.name),
                          value: gallery.name,
                          groupValue: tempGalleryName,
                          activeColor: Colors.brown,
                          onChanged: (value) => setDrawerState(() => tempGalleryName = value),
                        ),
                      ),
                      const _FilterDivider(),

                      // Color
                      const _FilterSectionTitle('Màu sắc'),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          // Option "Tất cả màu"
                          GestureDetector(
                            onTap: () => setDrawerState(() => tempColor = null),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: tempColor == null ? Colors.brown : Colors.transparent,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: tempColor == null ? Colors.brown : const Color(0xFFD0D0D0),
                                ),
                              ),
                              child: Text(
                                'Tất cả',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: tempColor == null ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          ),
                          ...colors.map((color) {
                            final isSelected = tempColor == color;
                            return GestureDetector(
                              onTap: () =>
                                  setDrawerState(() => tempColor = isSelected ? null : color),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: isSelected ? Colors.brown : Colors.transparent,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: isSelected ? Colors.brown : const Color(0xFFD0D0D0),
                                  ),
                                ),
                                child: Text(
                                  color,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isSelected ? Colors.white : Colors.black,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                      const _FilterDivider(),

                      // Price
                      const _FilterSectionTitle('Khoảng giá'),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: minPriceCtrl,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'Từ (đ)',
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              ),
                              onChanged: (value) => tempMinPrice = int.tryParse(value),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              controller: maxPriceCtrl,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'Đến (đ)',
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              ),
                              onChanged: (value) => tempMaxPrice = int.tryParse(value),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Buttons
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                            side: const BorderSide(color: Color(0xFFD0D0D0)),
                          ),
                          onPressed: () {
                            minPriceCtrl.clear();
                            maxPriceCtrl.clear();
                            Navigator.pop(context);
                            bloc.add(const ListItemFilterCleared());
                          },
                          child: const Text('Xoá bộ lọc'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.brown,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            bloc.add(
                              ListItemFilterApplied(
                                color: tempColor,
                                galleryName: tempGalleryName,
                                minPrice: tempMinPrice,
                                maxPrice: tempMaxPrice,
                              ),
                            );
                          },
                          child: const Text('Áp dụng'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _FilterBar extends StatelessWidget {
  const _FilterBar({
    required this.onTapAll,
    required this.galleries,
    required this.onTapGallery,
    required this.selectedGalleryName, // 👈 đổi từ selectedGalleryId
  });

  final VoidCallback onTapAll;
  final List<Gallery> galleries;
  final ValueChanged<Gallery> onTapGallery;
  final String? selectedGalleryName; // 👈

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListItemBloc, ListItemState>(
      buildWhen: (p, c) =>
          p.hasActiveFilter != c.hasActiveFilter ||
          p.selectedGalleryName != c.selectedGalleryName, // 👈
      builder: (context, state) {
        return SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _FilterPill(
                label: state.hasActiveFilter ? 'Bộ lọc (!)' : 'Bộ lọc',
                leading: Icons.tune,
                selected: state.hasActiveFilter,
                onTap: onTapAll,
              ),
              ...galleries.map(
                (gallery) => _FilterPill(
                  label: gallery.name,
                  selected: selectedGalleryName == gallery.name, // 👈
                  onTap: () => onTapGallery(gallery),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _FilterPill extends StatelessWidget {
  const _FilterPill({required this.label, this.leading, this.selected = false, this.onTap});

  final String label;
  final IconData? leading;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: selected ? Colors.brown : Colors.transparent,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: selected ? Colors.brown : const Color(0xFF3B3B3B)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (leading != null) ...[
                Icon(leading, size: 18, color: selected ? Colors.white : Colors.black),
                const SizedBox(width: 6),
              ],
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: selected ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ItemCard extends StatelessWidget {
  const _ItemCard({required this.item});
  final Item item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.router.push(ItemDetailRoute(itemId: item.id)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: item.imgUrl.isNotEmpty
                    ? Image.network(
                        item.imgUrl.first,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _placeholder(),
                      )
                    : _placeholder(),
              ),
            ),

            // Info
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF3D1F0A),
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Colors
                  Wrap(
                    spacing: 4,
                    children: item.color
                        .map(
                          (c) => Container(
                            width: 14,
                            height: 14,
                            decoration: BoxDecoration(
                              color: _colorFromName(c),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black12),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatPrice(item.price),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.brown,
                    ),
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
      color: const Color(0xFFD4B896),
      child: const Icon(Icons.checkroom_rounded, color: Colors.white54, size: 40),
    );
  }

  String _formatPrice(int price) {
    return '${price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')} đ';
  }

  Color _colorFromName(String name) {
    return switch (name.toLowerCase()) {
      'đỏ' => Colors.red,
      'trắng' => Colors.white,
      'đen' => Colors.black,
      'be' => const Color(0xFFD4B896),
      'tím' => Colors.purple,
      'xanh cổ vịt' => const Color(0xFF006D77),
      'hồng đào' => const Color(0xFFFF6B9D),
      _ => Colors.grey,
    };
  }
}

class _FilterSectionTitle extends StatelessWidget {
  const _FilterSectionTitle(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 6),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
    );
  }
}

class _FilterDivider extends StatelessWidget {
  const _FilterDivider();

  @override
  Widget build(BuildContext context) {
    return const Padding(padding: EdgeInsets.symmetric(vertical: 10), child: Divider(height: 1));
  }
}
