import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_farm/shared/shared.dart';

part 'base_bloc_event.dart';
part 'base_bloc_state.dart';

abstract class BaseBloc<E extends BaseBlocEvent, S extends BaseBlocState> extends Bloc<E, S> {
  BaseBloc(super.initialState);

  @override
  void add(E event) {
    if (!isClosed) {
      super.add(event);
    }
  }

  Future<void> runBlocCatching({
    required Future<void> Function() action,
    Future<void> Function(AppException)? doOnError,
    Future<void> Function()? doOnSubscribe,
    Future<void> Function()? doOnSuccessOrError,
    bool handleError = true,
  }) async {
    try {
      await doOnSubscribe?.call();
      await action();
    } on AppException catch (e) {
      await doOnError?.call(e);
    } catch (e) {
      await doOnError?.call(const RemoteException(kind: ExceptionKind.unknown));
    } finally {
      await doOnSuccessOrError?.call();
    }
  }
}
