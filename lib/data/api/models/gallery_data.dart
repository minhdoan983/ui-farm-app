import 'package:freezed_annotation/freezed_annotation.dart';

part 'gallery_data.freezed.dart';
part 'gallery_data.g.dart';

@freezed
sealed class GalleryData with _$GalleryData {
  const factory GalleryData({
    @JsonKey(name: '_id') String? id,
    String? name,
    List<String>? listItem,
  }) = _GalleryData;

  factory GalleryData.fromJson(Map<String, dynamic> json) => _$GalleryDataFromJson(json);
}
