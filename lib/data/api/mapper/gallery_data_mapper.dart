import 'package:injectable/injectable.dart';
import 'package:ui_farm/data/data.dart';
import 'package:ui_farm/domain/domain.dart';

@injectable
class GalleryDataMapper extends BaseDataMapper<GalleryData, Gallery> {
  const GalleryDataMapper();

  @override
  Gallery mapToEntity(GalleryData? data) {
    return Gallery(id: data?.id ?? '', name: data?.name ?? '', listItem: data?.listItem ?? []);
  }

  List<Gallery> mapToEntityList(List<GalleryData>? dataList) {
    return dataList?.map(mapToEntity).toList() ?? [];
  }
}
