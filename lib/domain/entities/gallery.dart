import 'package:freezed_annotation/freezed_annotation.dart';

part 'gallery.freezed.dart';

@freezed
sealed class Gallery with _$Gallery {
  const Gallery._();

  const factory Gallery({
    @Default('') String id,
    @Default('') String name,
    @Default([]) List<String> listItem,
  }) = _Gallery;
}
