import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_farm/core/bottom_bar_notifier.dart';
import 'package:ui_farm/ui/ui.dart';

@RoutePage()
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final scrollController = ScrollController();
  final bodyScrollController = ScrollController();
  double _lastOffset = 0;

  @override
  void initState() {
    super.initState();
    bodyScrollController.addListener(() {
      final offset = bodyScrollController.position.pixels;
      if (offset > _lastOffset && offset - _lastOffset > 10) {
        context.bottomBar.hide();
      } else if (offset < _lastOffset && _lastOffset - offset > 10) {
        context.bottomBar.show();
      }
      _lastOffset = offset;
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    bodyScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AppBloc, AppState>(
        buildWhen: (p, c) => p.items != c.items || p.isLoading != c.isLoading,
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator(color: Colors.brown));
          }

          final items = state.items;
          final carouselImages = items
              .where((e) => e.imgUrl.isNotEmpty)
              .take(5)
              .map((e) => e.imgUrl.first)
              .toList();

          final featuredItems = items.take(2).toList();

          final horizontalItems = items.skip(2).take(5).toList();

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            controller: bodyScrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  decoration: const BoxDecoration(color: Colors.brown),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'New collection is here. Shop now.',
                        style: TextStyle(color: Colors.white),
                      ),
                      Icon(Icons.arrow_right_alt_outlined, color: Colors.white),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    cursorColor: Colors.brown,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.all(20),
                      suffixIcon: const Icon(Icons.search, color: Colors.brown),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.brown, width: 2),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      hint: const Text('Search...', style: TextStyle(color: Colors.brown)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: Colors.brown, width: 2),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 36),

                if (carouselImages.isNotEmpty)
                  CarouselSlider(
                    items: carouselImages.map((url) {
                      return Builder(
                        builder: (context) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 6),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              url,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                color: const Color(0xFFD4B896),
                                child: const Icon(
                                  Icons.checkroom_rounded,
                                  color: Colors.white54,
                                  size: 40,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    options: CarouselOptions(
                      height: 280,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration: const Duration(milliseconds: 700),
                      autoPlayCurve: Curves.easeOutCubic,
                      viewportFraction: 0.62,
                      enlargeCenterPage: true,
                      enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                      clipBehavior: Clip.none,
                    ),
                  ),
                const SizedBox(height: 18),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 16),
                  child: const Text(
                    'Featured',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                      color: Colors.brown,
                    ),
                  ),
                ),

                ...featuredItems.map(
                  (item) => GestureDetector(
                    onTap: () => context.router.push(ItemDetailRoute(itemId: item.id)),
                    child: Stack(
                      children: [
                        item.imgUrl.isNotEmpty
                            ? Image.network(
                                item.imgUrl.first,
                                height: 640,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) =>
                                    Container(height: 640, color: const Color(0xFFD4B896)),
                              )
                            : Container(
                                height: 640,
                                color: const Color(0xFFD4B896),
                                child: const Icon(
                                  Icons.checkroom_rounded,
                                  color: Colors.white54,
                                  size: 80,
                                ),
                              ),
                        Positioned(
                          bottom: 10,
                          left: 10,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.name,
                                style: const TextStyle(color: Colors.white, fontSize: 20),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                _formatPrice(item.price),
                                style: const TextStyle(color: Colors.white, fontSize: 14),
                              ),
                              const SizedBox(height: 8),
                              ElevatedButton.icon(
                                onPressed: () =>
                                    context.router.push(ItemDetailRoute(itemId: item.id)),
                                iconAlignment: IconAlignment.end,
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(10),
                                  backgroundColor: Colors.brown[300],
                                ),
                                icon: const Icon(
                                  Icons.shopping_bag_outlined,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                label: const Text(
                                  'Shop',
                                  style: TextStyle(color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Text(
                    'More Items',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                      color: Colors.brown,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10).copyWith(bottom: 10),
                  child: RawScrollbar(
                    thickness: 6,
                    thumbColor: Colors.brown[300],
                    trackColor: Colors.transparent,
                    trackBorderColor: Colors.transparent,
                    trackRadius: const Radius.circular(10),
                    radius: const Radius.circular(10),
                    fadeDuration: const Duration(milliseconds: 100),
                    pressDuration: const Duration(milliseconds: 100),
                    scrollbarOrientation: ScrollbarOrientation.bottom,
                    thumbVisibility: true,
                    trackVisibility: true,
                    interactive: true,
                    controller: scrollController,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: horizontalItems
                              .map(
                                (item) => GestureDetector(
                                  onTap: () =>
                                      context.router.push(ItemDetailRoute(itemId: item.id)),
                                  child: Container(
                                    width: 200,
                                    margin: const EdgeInsets.only(right: 10),
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(12),
                                          child: item.imgUrl.isNotEmpty
                                              ? Image.network(
                                                  item.imgUrl.first,
                                                  width: 200,
                                                  height: 260,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (_, __, ___) => Container(
                                                    width: 200,
                                                    height: 260,
                                                    color: const Color(0xFFD4B896),
                                                  ),
                                                )
                                              : Container(
                                                  width: 200,
                                                  height: 260,
                                                  color: const Color(0xFFD4B896),
                                                  child: const Icon(
                                                    Icons.checkroom_rounded,
                                                    color: Colors.white54,
                                                    size: 40,
                                                  ),
                                                ),
                                        ),
                                        Positioned(
                                          bottom: 10,
                                          left: 10,
                                          right: 10,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                item.name,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              ElevatedButton(
                                                onPressed: () => context.router.push(
                                                  ItemDetailRoute(itemId: item.id),
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.white,
                                                  padding: const EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                    vertical: 4,
                                                  ),
                                                ),
                                                child: const Text(
                                                  'Shop',
                                                  style: TextStyle(color: Colors.black),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),
                const Center(child: Text('🇻🇳 UI Farm Ho Chi Minh city 🇻🇳')),
              ],
            ),
          );
        },
      ),
    );
  }

  String _formatPrice(int price) {
    final formatted = price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]}.',
    );
    return '$formatted đ';
  }
}
