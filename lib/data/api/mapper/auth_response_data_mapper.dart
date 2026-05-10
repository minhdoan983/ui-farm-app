import 'package:injectable/injectable.dart';
import 'package:ui_farm/data/data.dart';
import 'package:ui_farm/domain/domain.dart';

@injectable
class AuthResponseDataMapper extends BaseDataMapper<AuthResponseData, AuthToken> {
  const AuthResponseDataMapper(this._userDataMapper);

  final UserDataMapper _userDataMapper;

  @override
  AuthToken mapToEntity(AuthResponseData? data) {
    return AuthToken(accessToken: data?.accessToken ?? '');
  }

  User mapToUser(AuthResponseData? data) {
    return _userDataMapper.mapToEntity(data?.user);
  }
}
