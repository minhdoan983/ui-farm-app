part of 'profile_bloc.dart';

sealed class ProfileEvent extends BaseBlocEvent {
  const ProfileEvent();
}

@freezed
sealed class ProfileViewInitiated extends ProfileEvent with _$ProfileViewInitiated {
  const ProfileViewInitiated._();
  const factory ProfileViewInitiated() = _ProfileViewInitiated;
}

@freezed
sealed class ProfileNameTextFieldChanged extends ProfileEvent with _$ProfileNameTextFieldChanged {
  const ProfileNameTextFieldChanged._();
  const factory ProfileNameTextFieldChanged({required String name}) = _ProfileNameTextFieldChanged;
}

@freezed
sealed class ProfilePhoneTextFieldChanged extends ProfileEvent with _$ProfilePhoneTextFieldChanged {
  const ProfilePhoneTextFieldChanged._();
  const factory ProfilePhoneTextFieldChanged({required String phone}) =
      _ProfilePhoneTextFieldChanged;
}

@freezed
sealed class ProfileSaveButtonPressed extends ProfileEvent with _$ProfileSaveButtonPressed {
  const ProfileSaveButtonPressed._();
  const factory ProfileSaveButtonPressed() = _ProfileSaveButtonPressed;
}

@freezed
sealed class ProfileAvatarPickPressed extends ProfileEvent with _$ProfileAvatarPickPressed {
  const ProfileAvatarPickPressed._();
  const factory ProfileAvatarPickPressed() = _ProfileAvatarPickPressed;
}
