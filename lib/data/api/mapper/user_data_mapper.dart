import 'package:injectable/injectable.dart';
import 'package:ui_farm/data/data.dart';
import 'package:ui_farm/domain/domain.dart';

@injectable
class UserDataMapper extends BaseDataMapper<UserData, User> {
  const UserDataMapper();

  @override
  User mapToEntity(UserData? data) {
    return User(
      id: data?.id ?? '',
      name: data?.name ?? '',
      email: data?.email ?? '',
      phone: data?.phone ?? '',
      role: data?.role ?? '',
      avatarUrl: data?.avatarUrl ?? '',
      createdAt: data?.createdAt ?? '',
      updatedAt: data?.updatedAt ?? '',
    );
  }
}
