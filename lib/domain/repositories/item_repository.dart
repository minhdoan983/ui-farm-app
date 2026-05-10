import 'package:ui_farm/domain/domain.dart';

abstract class ItemRepository {
  Future<List<Item>> getItems();
  Future<List<Gallery>> getGalleries();
  Future<({List<Item> items, int totalItems})> getFilteredItems({
    String? color,
    String? galleryName,
    int? minPrice,
    int? maxPrice,
    int page,
  });
}
