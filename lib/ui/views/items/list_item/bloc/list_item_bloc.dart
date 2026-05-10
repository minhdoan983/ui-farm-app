import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:ui_farm/domain/domain.dart';
import 'package:ui_farm/ui/ui.dart';

part 'list_item_event.dart';
part 'list_item_state.dart';
part 'list_item_bloc.freezed.dart';

@injectable
class ListItemBloc extends BaseBloc<ListItemEvent, ListItemState> {
  ListItemBloc(this._getGalleriesUseCase, this._getFilteredItemsUseCase)
    : super(const ListItemState()) {
    on<ListItemViewInitiated>(_onViewInitiated);
    on<ListItemFilterApplied>(_onFilterApplied);
    on<ListItemFilterCleared>(_onFilterCleared);
    on<ListItemLoadMore>(_onLoadMore);
  }

  final GetGalleriesUseCase _getGalleriesUseCase;
  final GetFilteredItemsUseCase _getFilteredItemsUseCase;

  FutureOr<void> _onViewInitiated(ListItemViewInitiated event, Emitter<ListItemState> emit) async {
    await runBlocCatching(
      doOnSubscribe: () async => emit(state.copyWith(isLoading: true)),
      doOnSuccessOrError: () async => emit(state.copyWith(isLoading: false)),
      action: () async {
        // fetch galleries + items song song
        final results = await Future.wait([
          _getGalleriesUseCase.execute(const GetGalleriesInput()),
          _getFilteredItemsUseCase.execute(const GetFilteredItemsInput()),
        ]);

        final galleriesOutput = results[0] as GetGalleriesOutput;
        final itemsOutput = results[1] as GetFilteredItemsOutput;

        emit(
          state.copyWith(
            galleries: galleriesOutput.galleries,
            items: itemsOutput.items,
            totalItems: itemsOutput.totalItems,
            currentPage: 1,
            hasReachedMax: itemsOutput.items.length >= itemsOutput.totalItems,
          ),
        );
      },
    );
  }

  FutureOr<void> _onFilterApplied(ListItemFilterApplied event, Emitter<ListItemState> emit) async {
    emit(
      state.copyWith(
        selectedColor: event.color,
        selectedGalleryName: event.galleryName,
        minPrice: event.minPrice,
        maxPrice: event.maxPrice,
        currentPage: 1,
        items: [],
      ),
    );

    await runBlocCatching(
      doOnSubscribe: () async => emit(state.copyWith(isLoading: true)),
      doOnSuccessOrError: () async => emit(state.copyWith(isLoading: false)),
      action: () async {
        final output = await _getFilteredItemsUseCase.execute(
          GetFilteredItemsInput(
            color: event.color,
            galleryName: event.galleryName,
            minPrice: event.minPrice,
            maxPrice: event.maxPrice,
          ),
        );
        emit(
          state.copyWith(
            items: output.items,
            totalItems: output.totalItems,
            hasReachedMax: output.items.length >= output.totalItems,
          ),
        );
      },
    );
  }

  FutureOr<void> _onFilterCleared(ListItemFilterCleared event, Emitter<ListItemState> emit) async {
    emit(
      state.copyWith(
        selectedColor: null,
        selectedGalleryName: null,
        minPrice: null,
        maxPrice: null,
        currentPage: 1,
        items: [],
      ),
    );

    await runBlocCatching(
      doOnSubscribe: () async => emit(state.copyWith(isLoading: true)),
      doOnSuccessOrError: () async => emit(state.copyWith(isLoading: false)),
      action: () async {
        final output = await _getFilteredItemsUseCase.execute(const GetFilteredItemsInput());
        emit(
          state.copyWith(
            items: output.items,
            totalItems: output.totalItems,
            hasReachedMax: output.items.length >= output.totalItems,
          ),
        );
      },
    );
  }

  FutureOr<void> _onLoadMore(ListItemLoadMore event, Emitter<ListItemState> emit) async {
    if (state.isLoadingMore || state.hasReachedMax) return;

    await runBlocCatching(
      doOnSubscribe: () async => emit(state.copyWith(isLoadingMore: true)),
      doOnSuccessOrError: () async => emit(state.copyWith(isLoadingMore: false)),
      action: () async {
        final nextPage = state.currentPage + 1;
        final output = await _getFilteredItemsUseCase.execute(
          GetFilteredItemsInput(
            color: state.selectedColor,
            galleryName: state.selectedGalleryName,
            minPrice: state.minPrice,
            maxPrice: state.maxPrice,
            page: nextPage,
          ),
        );
        emit(
          state.copyWith(
            items: [...state.items, ...output.items],
            currentPage: nextPage,
            totalItems: output.totalItems,
            hasReachedMax: state.items.length + output.items.length >= output.totalItems,
          ),
        );
      },
    );
  }
}
