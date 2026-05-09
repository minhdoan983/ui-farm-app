import 'package:flutter/material.dart';
import 'package:ui_farm/resources/resources.dart';
import 'package:ui_farm/ui/ui.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'UI Farm',
      theme: AppThemes.appTheme,
      routerConfig: _appRouter.config(),
    );
  }
}
