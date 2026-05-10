part of 'profile_bloc.dart';

@freezed
sealed class ProfileState extends BaseBlocState with _$ProfileState {
  const ProfileState._();

  const factory ProfileState({
    @Default('') String userId,
    @Default('') String name,
    @Default('') String phone,
    @Default('') String email,
    @Default('') String avatarUrl,
    @Default(false) bool isLoading,
    @Default(false) bool isSaveSuccess,
    @Default('') String errorMessage,
    XFile? pickedImage,
  }) = _ProfileState;
}
