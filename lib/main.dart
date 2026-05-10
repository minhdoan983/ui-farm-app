import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ui_farm/di/injection.dart';
import 'package:ui_farm/resources/resources.dart';
import 'package:ui_farm/ui/ui.dart';

Future<void> main() async {
  await configureDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AppBloc>()..add(const AppStarted()),
      child: _AppView(appRouter: _appRouter),
    );
  }
}

class _AppView extends StatelessWidget {
  const _AppView({required this.appRouter});

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      listenWhen: (p, c) => p.isLoading != c.isLoading && !c.isLoading,
      listener: (context, state) {
        if (state.isAuthenticated) {
          appRouter.replaceAll([const MainRoute()]);
        } else {
          appRouter.replaceAll([const LoginRoute()]);
        }
      },
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'UI Farm',
        theme: AppThemes.appTheme,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        routerConfig: appRouter.config(),
      ),
    );
  }
}
