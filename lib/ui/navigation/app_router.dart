import 'package:auto_route/auto_route.dart';
import 'package:ui_farm/ui/ui.dart';

@AutoRouterConfig(replaceInRouteName: 'View,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: LoginRoute.page, initial: true),
    AutoRoute(page: RegisterRoute.page),
    AutoRoute(
      page: MainRoute.page,
      children: [
        AutoRoute(
          page: BottomTabHomeRouter.page,
          initial: true,
          children: [
            AutoRoute(page: HomeRoute.page, initial: true),
            AutoRoute(page: ContactRoute.page),
          ],
        ),
        AutoRoute(
          page: BottomTabProfileRouter.page,
          children: [
            AutoRoute(page: ProfileRoute.page, initial: true),
            AutoRoute(page: OrderManagementRoute.page),
          ],
        ),
        AutoRoute(
          page: BottomTabShopRouter.page,
          children: [
            AutoRoute(page: ListItemRoute.page, initial: true),
            AutoRoute(page: CartRoute.page),
            AutoRoute(page: ItemDetailRoute.page),
            AutoRoute(page: ItemManagementRoute.page),
          ],
        ),
      ],
    ),
  ];
}

@RoutePage(name: 'BottomTabHomeRouter')
class BottomTabHomeView extends AutoRouter {
  const BottomTabHomeView({super.key});
}

@RoutePage(name: 'BottomTabShopRouter')
class BottomTabShopView extends AutoRouter {
  const BottomTabShopView({super.key});
}

@RoutePage(name: 'BottomTabProfileRouter')
class BottomTabProfileView extends AutoRouter {
  const BottomTabProfileView({super.key});
}
