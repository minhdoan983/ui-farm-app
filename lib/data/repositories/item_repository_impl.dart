import 'package:injectable/injectable.dart';
import 'package:ui_farm/data/data.dart';
import 'package:ui_farm/domain/domain.dart';

@LazySingleton(as: ItemRepository)
class ItemRepositoryImpl implements ItemRepository {
  const ItemRepositoryImpl(this._appApiService, this._itemDataMapper, this._galleryDataMapper);

  final AppApiService _appApiService;
  final ItemDataMapper _itemDataMapper;
  final GalleryDataMapper _galleryDataMapper;

  @override
  Future<List<Item>> getItems() async {
    final response = await _appApiService.getItems();
    return _itemDataMapper.mapToEntityList(response);
  }

  @override
  Future<List<Gallery>> getGalleries() async {
    final response = await _appApiService.getGalleries();
    return _galleryDataMapper.mapToEntityList(response);
  }

  @override
  Future<({List<Item> items, int totalItems})> getFilteredItems({
    String? color,
    String? galleryName,
    int? minPrice,
    int? maxPrice,
    int page = 1,
  }) async {
    final response = await _appApiService.getFilteredItems(
      color: color,
      galleryName: galleryName,
      minPrice: minPrice,
      maxPrice: maxPrice,
      page: page,
    );
    return (
      items: _itemDataMapper.mapToEntityList(response?.items),
      totalItems: response?.totalItems ?? 0,
    );
  }
}
