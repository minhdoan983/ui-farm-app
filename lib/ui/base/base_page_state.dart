import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:ui_farm/ui/ui.dart';

abstract class BasePageState<T extends StatefulWidget, B extends BaseBloc> extends State<T> {
  late final B bloc = GetIt.instance.get<B>();

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(value: bloc, child: buildPage(context));
  }

  Widget buildPage(BuildContext context);
}
