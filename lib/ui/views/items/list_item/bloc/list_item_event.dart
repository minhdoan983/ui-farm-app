part of 'list_item_bloc.dart';

sealed class ListItemEvent extends BaseBlocEvent {
  const ListItemEvent();
}

@freezed
sealed class ListItemViewInitiated extends ListItemEvent with _$ListItemViewInitiated {
  const ListItemViewInitiated._();
  const factory ListItemViewInitiated() = _ListItemViewInitiated;
}

@freezed
sealed class ListItemFilterApplied extends ListItemEvent with _$ListItemFilterApplied {
  const ListItemFilterApplied._();
  const factory ListItemFilterApplied({
    String? color,
    String? galleryName,
    int? minPrice,
    int? maxPrice,
  }) = _ListItemFilterApplied;
}

@freezed
sealed class ListItemFilterCleared extends ListItemEvent with _$ListItemFilterCleared {
  const ListItemFilterCleared._();
  const factory ListItemFilterCleared() = _ListItemFilterCleared;
}

@freezed
sealed class ListItemLoadMore extends ListItemEvent with _$ListItemLoadMore {
  const ListItemLoadMore._();
  const factory ListItemLoadMore() = _ListItemLoadMore;
}
