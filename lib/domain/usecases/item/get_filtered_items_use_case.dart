import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:ui_farm/domain/domain.dart';

part 'get_filtered_items_use_case.freezed.dart';

@injectable
class GetFilteredItemsUseCase
    extends BaseFutureUseCase<GetFilteredItemsInput, GetFilteredItemsOutput> {
  const GetFilteredItemsUseCase(this._itemRepository);

  final ItemRepository _itemRepository;

  @override
  Future<GetFilteredItemsOutput> buildUseCase(GetFilteredItemsInput input) async {
    final result = await _itemRepository.getFilteredItems(
      color: input.color,
      galleryName: input.galleryName,
      minPrice: input.minPrice,
      maxPrice: input.maxPrice,
      page: input.page,
    );
    return GetFilteredItemsOutput(items: result.items, totalItems: result.totalItems);
  }
}

@freezed
sealed class GetFilteredItemsInput extends BaseInput with _$GetFilteredItemsInput {
  const GetFilteredItemsInput._();
  const factory GetFilteredItemsInput({
    String? color,
    String? galleryName,
    int? minPrice,
    int? maxPrice,
    @Default(1) int page,
  }) = _GetFilteredItemsInput;
}

@freezed
sealed class GetFilteredItemsOutput extends BaseOutput with _$GetFilteredItemsOutput {
  const GetFilteredItemsOutput._();
  const factory GetFilteredItemsOutput({
    @Default([]) List<Item> items,
    @Default(0) int totalItems,
  }) = _GetFilteredItemsOutput;
}
