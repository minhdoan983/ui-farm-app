part of 'app_bloc.dart';

@freezed
sealed class AppState extends BaseBlocState with _$AppState {
  const AppState._();

  const factory AppState({
    @Default([]) List<Item> items,
    @Default(false) bool isLoading,
    @Default(false) bool isAuthenticated,
    @Default(User()) User user,
    @Default(Cart()) Cart cart,
  }) = _AppState;
}
