import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:ui_farm/domain/domain.dart';

part 'get_galleries_use_case.freezed.dart';

@injectable
class GetGalleriesUseCase extends BaseFutureUseCase<GetGalleriesInput, GetGalleriesOutput> {
  const GetGalleriesUseCase(this._itemRepository);

  final ItemRepository _itemRepository;

  @override
  Future<GetGalleriesOutput> buildUseCase(GetGalleriesInput input) async {
    final galleries = await _itemRepository.getGalleries();
    return GetGalleriesOutput(galleries: galleries);
  }
}

@freezed
sealed class GetGalleriesInput extends BaseInput with _$GetGalleriesInput {
  const GetGalleriesInput._();
  const factory GetGalleriesInput() = _GetGalleriesInput;
}

@freezed
sealed class GetGalleriesOutput extends BaseOutput with _$GetGalleriesOutput {
  const GetGalleriesOutput._();
  const factory GetGalleriesOutput({@Default([]) List<Gallery> galleries}) = _GetGalleriesOutput;
}
