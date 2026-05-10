import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:ui_farm/domain/domain.dart';

part 'get_items_use_case.freezed.dart';

@injectable
class GetItemsUseCase extends BaseFutureUseCase<GetItemsInput, GetItemsOutput> {
  const GetItemsUseCase(this._itemRepository);

  final ItemRepository _itemRepository;

  @override
  Future<GetItemsOutput> buildUseCase(GetItemsInput input) async {
    final items = await _itemRepository.getItems();
    return GetItemsOutput(items: items);
  }
}

@freezed
sealed class GetItemsInput extends BaseInput with _$GetItemsInput {
  const GetItemsInput._();
  const factory GetItemsInput() = _GetItemsInput;
}

@freezed
sealed class GetItemsOutput extends BaseOutput with _$GetItemsOutput {
  const GetItemsOutput._();
  const factory GetItemsOutput({@Default([]) List<Item> items}) = _GetItemsOutput;
}
