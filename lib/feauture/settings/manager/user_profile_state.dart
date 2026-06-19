// update_profile_state.dart
abstract class UpdateProfileState {}
class UpdateProfileInitial extends UpdateProfileState {}
class UpdateProfileLoading extends UpdateProfileState {}
class UpdateProfileSuccess extends UpdateProfileState {}
class UpdateProfileFailure extends UpdateProfileState {
  final String message;
  UpdateProfileFailure(this.message);
}