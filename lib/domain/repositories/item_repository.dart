import 'package:ui_farm/domain/domain.dart';

abstract class ItemRepository {
  Future<List<Item>> getItems();
}
