import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ui_farm/data/data.dart';

part 'filtered_items_data.freezed.dart';
part 'filtered_items_data.g.dart';

@freezed
sealed class FilteredItemsData with _$FilteredItemsData {
  const factory FilteredItemsData({List<ItemData>? items, int? totalItems}) = _FilteredItemsData;

  factory FilteredItemsData.fromJson(Map<String, dynamic> json) =>
      _$FilteredItemsDataFromJson(json);
}
