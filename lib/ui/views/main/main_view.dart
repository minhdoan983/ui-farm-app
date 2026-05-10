import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_farm/core/core.dart';
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
        drawer: Drawer(width: MediaQuery.sizeOf(context).width, child: const _MainDrawer()),
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
                  icon: const Icon(Icons.menu_rounded, size: 30, color: Colors.brown),
                );
              },
            ),
            title: Center(
              child: Text(
                S.current.appTitle,
                style: const TextStyle(color: Colors.brown, fontWeight: FontWeight.bold),
              ),
            ),
            actions: [
              BlocBuilder<AppBloc, AppState>(
                buildWhen: (p, c) => p.cart.cartItems.length != c.cart.cartItems.length,
                builder: (context, state) {
                  final count = state.cart.cartItems.length;
                  return GestureDetector(
                    onTap: () => context.router.push(const CartRoute()),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
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
                        if (count > 0)
                          Positioned(
                            top: -6,
                            right: -6,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                              child: Text(
                                count > 99 ? S.current.cartBadge99 : '$count',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
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
                            tabsRouter.stackRouterOfIndex(value)?.popUntilRoot();
                          } else {
                            tabsRouter.setActiveIndex(value);
                          }
                        },
                        items: [
                          BottomNavigationBarItem(
                            icon: const Icon(CupertinoIcons.house),
                            activeIcon: const Icon(CupertinoIcons.house_fill),
                            label: S.current.bottomHome,
                          ),
                          BottomNavigationBarItem(
                            icon: const Icon(CupertinoIcons.person),
                            activeIcon: const Icon(CupertinoIcons.person_solid),
                            label: S.current.bottomProfile,
                          ),
                          BottomNavigationBarItem(
                            icon: const Icon(CupertinoIcons.shopping_cart),
                            activeIcon: const Icon(CupertinoIcons.cart_fill),
                            label: S.current.bottomStore,
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
  const _MainDrawer();

  static const _bgColor = Color(0xFFFFF7EF);
  static const _accent = Colors.brown;

  String _selectedLabel(BuildContext context) {
    final tabsRouter = AutoTabsRouter.of(context);
    final rootCurrent = context.router.current.name;
    final tabCurrent = tabsRouter.stackRouterOfIndex(tabsRouter.activeIndex)?.current.name;

    if (rootCurrent == OrderManagementRoute.name) {
      return S.current.drawerOrderManagement;
    }
    if (rootCurrent == ItemManagementRoute.name) {
      return S.current.drawerProductManagement;
    }
    if (tabCurrent == ContactRoute.name) {
      return S.current.drawerContact;
    }

    switch (tabsRouter.activeIndex) {
      case 1:
        return S.current.drawerProfileInfo;
      case 2:
        return S.current.drawerProducts;
      default:
        return S.current.drawerHome;
    }
  }

  @override
  Widget build(BuildContext context) {
    void closeDrawer() => Navigator.pop(context);
    final selectedLabel = _selectedLabel(context);

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
                  Text(
                    S.current.appTitle,
                    style: const TextStyle(
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
                    label: S.current.drawerHome,
                    isSelected: selectedLabel == S.current.drawerHome,
                    onTap: () {
                      Navigator.pop(context);
                      final tabsRouter = AutoTabsRouter.of(context);
                      tabsRouter.setActiveIndex(0);
                      tabsRouter.stackRouterOfIndex(0)?.popUntilRoot();
                    },
                  ),
                  _DrawerItem(
                    label: S.current.drawerProducts,
                    isSelected: selectedLabel == S.current.drawerProducts,
                    onTap: () {
                      Navigator.pop(context);
                      context.router.popUntilRoot();
                      AutoTabsRouter.of(context).setActiveIndex(2);
                    },
                  ),
                  _DrawerItem(
                    label: S.current.drawerStore,
                    isSelected: selectedLabel == S.current.drawerStore,
                    onTap: () {
                      Navigator.pop(context);
                      context.router.popUntilRoot();
                      AutoTabsRouter.of(context).setActiveIndex(2);
                    },
                  ),
                  _DrawerItem(
                    label: S.current.drawerContact,
                    isSelected: selectedLabel == S.current.drawerContact,
                    onTap: () {
                      Navigator.pop(context);
                      AutoTabsRouter.of(context).setActiveIndex(0);
                      context.router.push(const ContactRoute());
                    },
                  ),
                  const _DrawerSectionDivider(),
                  _DrawerItem(
                    label: S.current.drawerOrderManagement,
                    isSelected: selectedLabel == S.current.drawerOrderManagement,
                    onTap: () {
                      final tabsRouter = AutoTabsRouter.of(context);
                      Navigator.pop(context);
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        tabsRouter.setActiveIndex(1);
                        context.router.push(const OrderManagementRoute());
                      });
                    },
                  ),
                  _DrawerItem(
                    label: S.current.drawerProductManagement,
                    isSelected: selectedLabel == S.current.drawerProductManagement,
                    onTap: () {
                      final tabsRouter = AutoTabsRouter.of(context);
                      Navigator.pop(context);
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        tabsRouter.setActiveIndex(2);
                        context.router.push(const ItemManagementRoute());
                      });
                    },
                  ),
                  _DrawerItem(
                    label: S.current.drawerProfileInfo,
                    isSelected: selectedLabel == S.current.drawerProfileInfo,
                    onTap: () {
                      final tabsRouter = AutoTabsRouter.of(context);
                      Navigator.pop(context);
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        tabsRouter.setActiveIndex(1);
                      });
                    },
                  ),
                  _DrawerItem(
                    label: S.current.drawerLogout,
                    isSelected: selectedLabel == S.current.drawerLogout,
                    onTap: closeDrawer,
                    isDestructive: true,
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
    return const Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Divider(height: 1));
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
    final color = isSelected ? Colors.white : (isDestructive ? Colors.red : Colors.brown);
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
