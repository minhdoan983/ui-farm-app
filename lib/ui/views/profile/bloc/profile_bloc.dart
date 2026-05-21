import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:ui_farm/di/injection.dart';
import 'package:ui_farm/domain/domain.dart';
import 'package:ui_farm/shared/shared.dart';
import 'package:ui_farm/ui/ui.dart';

part 'profile_event.dart';
part 'profile_state.dart';
part 'profile_bloc.freezed.dart';

@injectable
class ProfileBloc extends BaseBloc<ProfileEvent, ProfileState> {
  ProfileBloc(this._updateProfileUseCase) : super(const ProfileState()) {
    on<ProfileViewInitiated>(_onViewInitiated);
    on<ProfileNameTextFieldChanged>(_onNameChanged);
    on<ProfilePhoneTextFieldChanged>(_onPhoneChanged);
    on<ProfileSaveButtonPressed>(_onSaveButtonPressed);
    on<ProfileAvatarPickPressed>(_onAvatarPickPressed);
  }

  final UpdateProfileUseCase _updateProfileUseCase;

  FutureOr<void> _onViewInitiated(ProfileViewInitiated event, Emitter<ProfileState> emit) {
    final user = getIt<AppBloc>().state.user;
    emit(
      state.copyWith(
        userId: user.id,
        name: user.name,
        phone: user.phone,
        email: user.email,
        avatarUrl: user.avatarUrl,
      ),
    );
  }

  FutureOr<void> _onNameChanged(ProfileNameTextFieldChanged event, Emitter<ProfileState> emit) {
    emit(state.copyWith(name: event.name, errorMessage: ''));
  }

  FutureOr<void> _onPhoneChanged(ProfilePhoneTextFieldChanged event, Emitter<ProfileState> emit) {
    emit(state.copyWith(phone: event.phone, errorMessage: ''));
  }

  FutureOr<void> _onSaveButtonPressed(
    ProfileSaveButtonPressed event,
    Emitter<ProfileState> emit,
  ) async {
    await runBlocCatching(
      doOnSubscribe: () async => emit(state.copyWith(isLoading: true)),
      doOnSuccessOrError: () async => emit(state.copyWith(isLoading: false)),
      action: () async {
        final output = await _updateProfileUseCase.execute(
          UpdateProfileInput(userId: state.userId, name: state.name, phone: state.phone),
        );
        getIt<AppBloc>().add(AppUserUpdated(user: output.user));
        emit(state.copyWith(isSaveSuccess: true));
      },
      doOnError: (error) async {
        final message = error is RemoteException ? error.generalMessage : 'Cập nhật thất bại';
        emit(state.copyWith(errorMessage: message));
      },
    );
  }

  FutureOr<void> _onAvatarPickPressed(
    ProfileAvatarPickPressed event,
    Emitter<ProfileState> emit,
  ) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (image != null) {
      emit(state.copyWith(pickedImage: image));
    }
  }
}
