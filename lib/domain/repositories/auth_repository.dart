import 'package:ui_farm/domain/domain.dart';

abstract class AuthRepository {
  Future<User> login({required String email, required String password});
  Future<User> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  });
  Future<void> logout();
  Future<String?> getToken();
  Future<User> getMe();
  Future<User> updateProfile({required String userId, required String name, required String phone});
}
