import 'package:flutter/material.dart';

class BottomBarNotifier extends ValueNotifier<bool> {
  BottomBarNotifier() : super(true);

  void hide() => value = false;
  void show() => value = true;
}

class BottomBarProvider extends InheritedWidget {
  const BottomBarProvider({super.key, required this.notifier, required super.child});
  final BottomBarNotifier notifier;

  static BottomBarNotifier of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<BottomBarProvider>()!.notifier;
  }

  @override
  bool updateShouldNotify(BottomBarProvider oldWidget) {
    return notifier != oldWidget.notifier;
  }
}

extension BottomBarExt on BuildContext {
  BottomBarNotifier get bottomBar => BottomBarProvider.of(this);
}
