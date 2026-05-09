import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_farm/core/bottom_bar_notifier.dart';
import 'package:ui_farm/resources/resources.dart';
import 'package:ui_farm/ui/ui.dart';

@RoutePage()
class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  late BottomBarNotifier _bottomBarNotifier;

  @override
  void initState() {
    super.initState();
    _bottomBarNotifier = BottomBarNotifier();
  }

  @override
  void dispose() {
    _bottomBarNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BottomBarProvider(
      notifier: _bottomBarNotifier,
      child: AutoTabsScaffold(
        routes: const [BottomTabHomeRouter(), ProfileRoute(), ListItemRoute()],
        drawer: Drawer(
          width: MediaQuery.sizeOf(context).width,
          child: const _MainDrawer(selectedLabel: 'Trang chủ'),
        ),
        appBarBuilder: (context, tabsRouter) {
          return AppBar(
            centerTitle: true,
            shadowColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            backgroundColor: Colors.white,
            actionsPadding: const EdgeInsets.only(right: 20),
            leading: Builder(
              builder: (context) {
                return IconButton(
                  onPressed: () => Scaffold.of(context).openDrawer(),
                  icon: const Icon(
                    Icons.menu_rounded,
                    size: 30,
                    color: Colors.brown,
                  ),
                );
              },
            ),
            title: const Center(
              child: Text(
                "UI Farm",
                style: TextStyle(
                  color: Colors.brown,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: () => context.router.push(const CartRoute()),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.brown, width: 2),
                  ),
                  child: const Icon(
                    Icons.shopping_bag_outlined,
                    size: 30,
                    color: Colors.brown,
                  ),
                ),
              ),
            ],
          );
        },
        bottomNavigationBuilder: (_, tabsRouter) {
          return ValueListenableBuilder<bool>(
            valueListenable: _bottomBarNotifier,
            builder: (context, showBar, _) {
              return AnimatedSize(
                duration: const Duration(milliseconds: 250),
                child: showBar
                    ? BottomNavigationBar(
                        backgroundColor: Colors.white,
                        selectedItemColor: Colors.brown,
                        currentIndex: tabsRouter.activeIndex,
                        onTap: (value) {
                          if (tabsRouter.activeIndex == value) {
                            tabsRouter
                                .stackRouterOfIndex(value)
                                ?.popUntilRoot();
                          } else {
                            tabsRouter.setActiveIndex(value);
                          }
                        },
                        items: const [
                          BottomNavigationBarItem(
                            icon: Icon(CupertinoIcons.house),
                            activeIcon: Icon(CupertinoIcons.house_fill),
                            label: 'Home',
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(CupertinoIcons.person),
                            activeIcon: Icon(CupertinoIcons.person_solid),
                            label: 'Profile',
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(CupertinoIcons.shopping_cart),
                            activeIcon: Icon(CupertinoIcons.cart_fill),
                            label: 'Shop',
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
              );
            },
          );
        },
      ),
    );
  }
}

class _MainDrawer extends StatelessWidget {
  const _MainDrawer({required this.selectedLabel});

  static const _bgColor = Color(0xFFFFF7EF);
  static const _accent = Colors.brown;
  final String selectedLabel;

  @override
  Widget build(BuildContext context) {
    void closeDrawer() => Navigator.pop(context);

    return SafeArea(
      child: Container(
        color: _bgColor,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
              child: Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: _accent, width: 2),
                    ),
                    child: Assets.images.logoPng.image(),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'UI Farm',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: _accent,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: [
                  _DrawerItem(
                    label: 'Trang chủ',
                    isSelected: selectedLabel == 'Trang chủ',
                    onTap: () {
                      Navigator.pop(context);
                      final tabsRouter = AutoTabsRouter.of(context);
                      tabsRouter.setActiveIndex(0);
                      tabsRouter.stackRouterOfIndex(0)?.popUntilRoot();
                    },
                  ),
                  _DrawerItem(
                    label: 'Sản phẩm',
                    isSelected: selectedLabel == 'Sản phẩm',
                    onTap: () {
                      Navigator.pop(context);
                      context.router.popUntilRoot();
                      AutoTabsRouter.of(context).setActiveIndex(2);
                    },
                  ),
                  _DrawerItem(
                    label: 'Cửa hàng',
                    isSelected: selectedLabel == 'Cửa hàng',
                    onTap: () {
                      Navigator.pop(context);
                      context.router.popUntilRoot();
                      AutoTabsRouter.of(context).setActiveIndex(2);
                    },
                  ),
                  _DrawerItem(
                    label: 'Liên hệ',
                    isSelected: selectedLabel == 'Liên hệ',
                    onTap: () {
                      Navigator.pop(context);
                      AutoTabsRouter.of(context).setActiveIndex(0);
                      context.router.push(const ContactRoute());
                    },
                  ),
                  const _DrawerSectionDivider(),
                  _DrawerItem(
                    label: 'Quản lý đơn hàng',
                    isSelected: selectedLabel == 'Quản lý đơn hàng',
                    onTap: () {
                      final tabsRouter = AutoTabsRouter.of(context);
                      Navigator.pop(context);
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        tabsRouter.setActiveIndex(1); // index của Profile tab
                        context.router.push(const OrderManagementRoute());
                      });
                    },
                  ),
                  _DrawerItem(
                    label: 'Quản lý sản phẩm',
                    isSelected: selectedLabel == 'Quản lý sản phẩm',
                    onTap: () {
                      final tabsRouter = AutoTabsRouter.of(context);
                      Navigator.pop(context);
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        tabsRouter.setActiveIndex(2); // index của Shop tab
                        context.router.push(const ItemManagementRoute());
                      });
                    },
                  ),
                  _DrawerItem(
                    label: 'Thông tin cá nhân',
                    isSelected: selectedLabel == 'Thông tin cá nhân',
                    onTap: closeDrawer,
                  ),
                  _DrawerItem(
                    label: 'Đăng xuất',
                    isDestructive: true,
                    isSelected: selectedLabel == 'Đăng xuất',
                    onTap: closeDrawer,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerSectionDivider extends StatelessWidget {
  const _DrawerSectionDivider();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Divider(height: 1),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  const _DrawerItem({
    required this.label,
    this.isDestructive = false,
    this.isSelected = false,
    this.onTap,
  });

  final String label;
  final bool isDestructive;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final color = isSelected
        ? Colors.white
        : (isDestructive ? Colors.red : Colors.brown);
    final background = isSelected ? Colors.brown : Colors.white;
    final borderColor = isSelected ? Colors.brown : const Color(0xFFE4D8CC);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: borderColor),
          ),
          child: Text(
            label,
            style: TextStyle(color: color, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
