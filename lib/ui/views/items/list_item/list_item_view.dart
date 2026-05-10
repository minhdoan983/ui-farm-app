import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ui_farm/resources/resources.dart';

@RoutePage()
class ListItemView extends StatefulWidget {
  const ListItemView({super.key});

  @override
  State<ListItemView> createState() => _ListItemViewState();
}

class _ListItemViewState extends State<ListItemView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openAllFilters() {
    _scaffoldKey.currentState?.openDrawer();
  }

  Drawer _buildAllFiltersDrawer() {
    var sortBy = 1;
    var men = true;
    var women = false;
    var unisex = false;
    var under1m = false;
    var sale = false;
    var colorPurple = false;
    var colorBlack = true;
    var colorRed = false;

    return Drawer(
      child: SafeArea(
        child: StatefulBuilder(
          builder: (context, setState) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Filter',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () => Navigator.pop(context),
                        child: const Padding(
                          padding: EdgeInsets.all(6),
                          child: Icon(Icons.close, size: 20),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
                    children: [
                      const _FilterSectionTitle('Sort By'),
                      _RadioTile(
                        label: 'Featured',
                        value: 0,
                        groupValue: sortBy,
                        onChanged: (value) => setState(() => sortBy = value),
                      ),
                      _RadioTile(
                        label: 'Newest',
                        value: 1,
                        groupValue: sortBy,
                        onChanged: (value) => setState(() => sortBy = value),
                      ),
                      _RadioTile(
                        label: 'Price: High-Low',
                        value: 2,
                        groupValue: sortBy,
                        onChanged: (value) => setState(() => sortBy = value),
                      ),
                      _RadioTile(
                        label: 'Price: Low-High',
                        value: 3,
                        groupValue: sortBy,
                        onChanged: (value) => setState(() => sortBy = value),
                      ),
                      const _FilterDivider(),
                      const _FilterSectionTitle('Gender (1)'),
                      _CheckTile(
                        label: 'Men',
                        value: men,
                        onChanged: (value) => setState(() => men = value),
                      ),
                      _CheckTile(
                        label: 'Women',
                        value: women,
                        onChanged: (value) => setState(() => women = value),
                      ),
                      _CheckTile(
                        label: 'Unisex',
                        value: unisex,
                        onChanged: (value) => setState(() => unisex = value),
                      ),
                      const _FilterDivider(),
                      const _FilterSectionTitle('Shop By Price'),
                      _CheckTile(
                        label: 'Under 1,000,000đ',
                        value: under1m,
                        onChanged: (value) => setState(() => under1m = value),
                      ),
                      const _FilterDivider(),
                      const _FilterSectionTitle('Sale & Offers'),
                      _CheckTile(
                        label: 'Sale',
                        value: sale,
                        onChanged: (value) => setState(() => sale = value),
                      ),
                      const _FilterDivider(),
                      const _FilterSectionTitle('Colour'),
                      Row(
                        children: [
                          _ColorDot(
                            label: 'Purple',
                            color: const Color(0xFF7E3F98),
                            selected: colorPurple,
                            onTap: () => setState(() => colorPurple = !colorPurple),
                          ),
                          const SizedBox(width: 12),
                          _ColorDot(
                            label: 'Black',
                            color: Colors.black,
                            selected: colorBlack,
                            onTap: () => setState(() => colorBlack = !colorBlack),
                          ),
                          const SizedBox(width: 12),
                          _ColorDot(
                            label: 'Red',
                            color: Colors.red,
                            selected: colorRed,
                            onTap: () => setState(() => colorRed = !colorRed),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
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
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Clear (1)'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                          ),
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Apply'),
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

  void _openGenderFilter() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        var men = true;
        var women = false;
        var unisex = false;

        return StatefulBuilder(
          builder: (context, setState) {
            return SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Filter by Gender',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () => Navigator.pop(context),
                          child: const Padding(
                            padding: EdgeInsets.all(6),
                            child: Icon(Icons.close, size: 20),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Men'),
                      value: men,
                      onChanged: (value) => setState(() {
                        men = value ?? false;
                      }),
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Women'),
                      value: women,
                      onChanged: (value) => setState(() {
                        women = value ?? false;
                      }),
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Unisex'),
                      value: unisex,
                      onChanged: (value) => setState(() {
                        unisex = value ?? false;
                      }),
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Apply'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _openPriceFilter() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Shop By Price',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () => Navigator.pop(context),
                      child: const Padding(
                        padding: EdgeInsets.all(6),
                        child: Icon(Icons.close, size: 20),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text('Chưa có nội dung filter giá.'),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Apply'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: _buildAllFiltersDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 12, left: 18, right: 18),
              child: _FilterBar(
                onTapAll: _openAllFilters,
                onTapGender: _openGenderFilter,
                onTapPrice: _openPriceFilter,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(18, 12, 18, 0),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 20,
                mainAxisExtent: 360,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) => const _ItemCard(),
                childCount: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterBar extends StatelessWidget {
  const _FilterBar({required this.onTapAll, required this.onTapGender, required this.onTapPrice});

  final VoidCallback onTapAll;
  final VoidCallback onTapGender;
  final VoidCallback onTapPrice;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _FilterPill(label: '(1)', leading: Icons.tune, selected: true, onTap: onTapAll),
          _FilterPill(label: 'Gender (1)', trailing: Icons.keyboard_arrow_down, onTap: onTapGender),
          _FilterPill(
            label: 'Shop By Price',
            trailing: Icons.keyboard_arrow_down,
            onTap: onTapPrice,
          ),
        ],
      ),
    );
  }
}

class _FilterPill extends StatelessWidget {
  const _FilterPill({
    required this.label,
    this.leading,
    this.trailing,
    this.selected = false,
    this.onTap,
  });

  final String label;
  final IconData? leading;
  final IconData? trailing;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final borderColor = selected ? Colors.black : const Color(0xFF3B3B3B);

    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: borderColor),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (leading != null) ...[Icon(leading, size: 18), const SizedBox(width: 6)],
              Text(
                label,
                style: TextStyle(fontWeight: selected ? FontWeight.w600 : FontWeight.w500),
              ),
              if (trailing != null) ...[const SizedBox(width: 6), Icon(trailing, size: 18)],
            ],
          ),
        ),
      ),
    );
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

class _RadioTile extends StatelessWidget {
  const _RadioTile({
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  final String label;
  final int value;
  final int groupValue;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return RadioListTile<int>(
      contentPadding: EdgeInsets.zero,
      title: Text(label),
      value: value,
      // ignore: deprecated_member_use
      onChanged: (value) {
        if (value != null) {
          onChanged(value);
        }
      },
    );
  }
}

class _CheckTile extends StatelessWidget {
  const _CheckTile({required this.label, required this.value, required this.onChanged});

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(label),
      value: value,
      onChanged: (value) {
        if (value != null) {
          onChanged(value);
        }
      },
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}

class _ColorDot extends StatelessWidget {
  const _ColorDot({
    required this.label,
    required this.color,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final Color color;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(26),
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(color: selected ? Colors.black : Colors.transparent, width: 2),
            ),
          ),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}

class _ItemCard extends StatelessWidget {
  const _ItemCard();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            SizedBox(
              height: 200,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Assets.images.shirt1.image(fit: BoxFit.cover),
              ),
            ),
            const Text('Áo dài hướng dương thêu chữ', maxLines: 2, overflow: TextOverflow.ellipsis),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                Container(
                  width: 30,
                  height: 15,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                Container(
                  width: 30,
                  height: 15,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                Container(
                  width: 30,
                  height: 15,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(),
                  ),
                ),
                Container(
                  width: 30,
                  height: 15,
                  decoration: BoxDecoration(
                    color: Colors.brown,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(),
                  ),
                ),
                Container(
                  width: 30,
                  height: 15,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(),
                  ),
                ),
              ],
            ),
            Text('Giá: 3.415.000'),
          ],
        ),
      ),
    );
  }
}
