import 'package:freezed_annotation/freezed_annotation.dart';

part 'item.freezed.dart';

@freezed
sealed class Item with _$Item {
  const Item._();

  const factory Item({
    @Default('') String id,
    @Default('') String name,
    @Default([]) List<String> material,
    @Default(0) int price,
    @Default([]) List<String> color,
    @Default([]) List<String> imgUrl,
    @Default('') String createdAt,
    @Default('') String updatedAt,
  }) = _Item;
}
