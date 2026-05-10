import 'package:injectable/injectable.dart';
import 'package:ui_farm/data/data.dart';
import 'package:ui_farm/domain/domain.dart';

@LazySingleton(as: ItemRepository)
class ItemRepositoryImpl implements ItemRepository {
  const ItemRepositoryImpl(this._appApiService, this._itemDataMapper);

  final AppApiService _appApiService;
  final ItemDataMapper _itemDataMapper;

  @override
  Future<List<Item>> getItems() async {
    final response = await _appApiService.getItems();
    return _itemDataMapper.mapToEntityList(response);
  }
}
