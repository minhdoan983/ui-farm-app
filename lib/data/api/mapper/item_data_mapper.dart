import 'package:injectable/injectable.dart';
import 'package:ui_farm/data/data.dart';
import 'package:ui_farm/domain/domain.dart';

@injectable
class ItemDataMapper extends BaseDataMapper<ItemData, Item> {
  const ItemDataMapper();

  @override
  Item mapToEntity(ItemData? data) {
    return Item(
      id: data?.id ?? '',
      name: data?.name ?? '',
      material: data?.material ?? [],
      price: data?.price ?? 0,
      color: data?.color ?? [],
      imgUrl: data?.imgUrl ?? [],
      createdAt: data?.createdAt ?? '',
      updatedAt: data?.updatedAt ?? '',
    );
  }

  List<Item> mapToEntityList(List<ItemData>? dataList) {
    return dataList?.map(mapToEntity).toList() ?? [];
  }
}
