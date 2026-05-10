import 'package:injectable/injectable.dart';
import 'package:ui_farm/data/data.dart';

@lazySingleton
class AppApiService {
  const AppApiService(this._serverApiClient);

  final ServerApiClient _serverApiClient;

  Future<AuthResponseData?> login({required String email, required String password}) async {
    return await _serverApiClient.request(
      method: RequestMethod.post,
      path: '/auth/login',
      body: LoginRequestData(email: email, password: password).toJson(),
      decoder: (data) => AuthResponseData.fromJson(data as Map<String, dynamic>),
    );
  }

  Future<UserData?> getMe() async {
    return await _serverApiClient.request(
      method: RequestMethod.get,
      path: '/users/me',
      decoder: (data) => UserData.fromJson(data as Map<String, dynamic>),
    );
  }

  Future<AuthResponseData?> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    return await _serverApiClient.request(
      method: RequestMethod.post,
      path: '/users',
      body: {'name': name, 'email': email, 'phone': phone, 'password': password},
      decoder: (data) => AuthResponseData.fromJson(data as Map<String, dynamic>),
    );
  }

  Future<List<ItemData>> getItems() async {
    final result = await _serverApiClient.request(
      method: RequestMethod.get,
      path: '/items',
      decoder: (data) =>
          (data as List<dynamic>).map((e) => ItemData.fromJson(e as Map<String, dynamic>)).toList(),
    );
    return result ?? [];
  }

  Future<UserData?> updateProfile({
    required String userId,
    required String name,
    required String phone,
  }) async {
    return await _serverApiClient.request(
      method: RequestMethod.put,
      path: '/users/$userId',
      body: {'name': name, 'phone': phone},
      decoder: (data) => UserData.fromJson(data as Map<String, dynamic>),
    );
  }

  Future<CartData?> getCart({required String userId}) async {
    return await _serverApiClient.request(
      method: RequestMethod.get,
      path: '/cart/',
      queryParameters: {'id': userId},
      decoder: (data) => CartData.fromJson(data as Map<String, dynamic>),
    );
  }

  Future<void> removeCartItem({required String userId, required String itemId}) async {
    await _serverApiClient.request(
      method: RequestMethod.patch,
      path: '/cart/remove',
      queryParameters: {'id': userId},
      body: {'itemId': itemId},
      decoder: (_) {},
    );
  }

  Future<void> updateCartQuantity({
    required String userId,
    required String itemId,
    required int quantity,
  }) async {
    await _serverApiClient.request(
      method: RequestMethod.patch,
      path: '/cart/updateQuantity',
      body: {'userId': userId, 'itemId': itemId, 'quantity': quantity},
      decoder: (_) {},
    );
  }

  Future<List<OrderData>> getOrders() async {
    final result = await _serverApiClient.request(
      method: RequestMethod.get,
      path: '/payment',
      decoder: (data) => (data as List<dynamic>)
          .map((e) => OrderData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
    return result ?? [];
  }
}
