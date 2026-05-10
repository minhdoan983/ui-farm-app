import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

EventTransformer<E> log<E>() => droppable<E>();

EventTransformer<E> distinct<E>() {
  return (events, mapper) => events.distinct().switchMap(mapper);
}
