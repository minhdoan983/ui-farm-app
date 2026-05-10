import 'package:freezed_annotation/freezed_annotation.dart';

part 'item_data.freezed.dart';
part 'item_data.g.dart';

@freezed
sealed class ItemData with _$ItemData {
  const factory ItemData({
    @JsonKey(name: '_id') String? id,
    String? name,
    List<String>? material,
    int? price,
    List<String>? color,
    List<String>? imgUrl,
    String? createdAt,
    String? updatedAt,
  }) = _ItemData;

  factory ItemData.fromJson(Map<String, dynamic> json) => _$ItemDataFromJson(json);
}
