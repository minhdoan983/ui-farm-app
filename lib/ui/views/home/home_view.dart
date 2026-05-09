import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ui_farm/core/bottom_bar_notifier.dart';
import 'package:ui_farm/resources/resources.dart';

@RoutePage()
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final scrollController = ScrollController(); // cho RawScrollbar (ngang)
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
    bodyScrollController.dispose(); // THÊM
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                    "New collection is here. Shop now.",
                    textAlign: TextAlign.start,
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
                  hint: const Text(
                    'Search...',
                    style: TextStyle(color: Colors.brown),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.brown, width: 2),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 36),
            CarouselSlider(
              items:
                  [
                    Assets.images.shirt1.image(fit: BoxFit.cover),
                    Assets.images.shirt2.image(fit: BoxFit.cover),
                    Assets.images.shirt3.image(fit: BoxFit.cover),
                    Assets.images.shirt4.image(fit: BoxFit.cover),
                    Assets.images.shirt5.image(fit: BoxFit.cover),
                  ].map((img) {
                    return Builder(
                      builder: (context) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 6),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox(width: double.infinity, child: img),
                          ),
                        );
                      },
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
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ).copyWith(bottom: 16),
              child: const Text(
                'Featured',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                  color: Colors.brown,
                ),
              ),
            ),
            Stack(
              children: [
                Assets.images.shirt1.image(
                  height: 640,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Áo dài Hướng dương thêu chữ',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: () {},
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
            Stack(
              children: [
                Assets.images.shirt2.image(
                  height: 640,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Áo dài Hướng dương thêu chữ',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: () {},
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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Text(
                'Featured',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                  color: Colors.brown,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ).copyWith(bottom: 10),
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
                  padding: EdgeInsetsGeometry.symmetric(vertical: 10),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            Assets.images.shirt1.image(
                              width: 200,
                              fit: BoxFit.scaleDown,
                            ),
                            Positioned(
                              bottom: 10,
                              left: 10,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                ),
                                child: Text(
                                  'Shop',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 10),
                        Assets.images.shirt1.image(
                          width: 200,
                          fit: BoxFit.scaleDown,
                        ),
                        SizedBox(width: 10),
                        Assets.images.shirt1.image(
                          width: 200,
                          fit: BoxFit.scaleDown,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Center(child: Text('🇻🇳 UI Farm Ho Chi Minh city 🇻🇳')),
          ],
        ),
      ),
    );
  }
}
