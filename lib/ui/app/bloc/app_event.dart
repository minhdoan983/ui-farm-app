part of 'app_bloc.dart';

sealed class AppEvent extends BaseBlocEvent {
  const AppEvent();
}

@freezed
sealed class AppStarted extends AppEvent with _$AppStarted {
  const AppStarted._();
  const factory AppStarted() = _AppStarted;
}

@freezed
sealed class AppUserUpdated extends AppEvent with _$AppUserUpdated {
  const AppUserUpdated._();
  const factory AppUserUpdated({required User user}) = _AppUserUpdated;
}

@freezed
sealed class AppCartUpdated extends AppEvent with _$AppCartUpdated {
  const AppCartUpdated._();
  const factory AppCartUpdated() = _AppCartUpdated;
}
