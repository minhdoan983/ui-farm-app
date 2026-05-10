import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:ui_farm/data/data.dart';
import 'package:ui_farm/domain/domain.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(
    this._appApiService,
    this._authResponseDataMapper,
    this._userDataMapper,
    this._secureStorage,
  );

  final AppApiService _appApiService;
  final AuthResponseDataMapper _authResponseDataMapper;
  final UserDataMapper _userDataMapper;
  final FlutterSecureStorage _secureStorage;

  static const _tokenKey = 'auth_token';

  @override
  Future<User> login({required String email, required String password}) async {
    final response = await _appApiService.login(email: email, password: password);
    final token = _authResponseDataMapper.mapToEntity(response);
    await _secureStorage.write(key: _tokenKey, value: token.accessToken);
    return _authResponseDataMapper.mapToUser(response);
  }

  @override
  Future<void> logout() async {
    await _secureStorage.delete(key: _tokenKey);
  }

  @override
  Future<String?> getToken() => _secureStorage.read(key: _tokenKey);

  @override
  Future<User> getMe() async {
    final response = await _appApiService.getMe();
    return _userDataMapper.mapToEntity(response);
  }

  @override
  Future<User> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    final response = await _appApiService.register(
      name: name,
      email: email,
      phone: phone,
      password: password,
    );
    final token = _authResponseDataMapper.mapToEntity(response);
    await _secureStorage.write(key: _tokenKey, value: token.accessToken);
    return _authResponseDataMapper.mapToUser(response);
  }

  @override
  Future<User> updateProfile({
    required String userId,
    required String name,
    required String phone,
  }) async {
    final response = await _appApiService.updateProfile(userId: userId, name: name, phone: phone);
    return _userDataMapper.mapToEntity(response);
  }
}
