part of 'list_item_bloc.dart';

@freezed
sealed class ListItemState extends BaseBlocState with _$ListItemState {
  const ListItemState._();

  const factory ListItemState({
    @Default([]) List<Item> items,
    @Default([]) List<Gallery> galleries,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    @Default(false) bool hasReachedMax,
    @Default(1) int currentPage,
    @Default(0) int totalItems,
    @Default('') String errorMessage,
    String? selectedColor,
    String? selectedGalleryName,
    int? minPrice,
    int? maxPrice,
  }) = _ListItemState;

  bool get hasActiveFilter =>
      selectedColor != null || selectedGalleryName != null || minPrice != null || maxPrice != null;
}
