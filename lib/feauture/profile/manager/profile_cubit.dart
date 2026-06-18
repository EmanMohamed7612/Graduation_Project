import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:graduation2/core/services/api_services.dart';
import 'package:graduation2/feauture/profile/data/user_profile_repo.dart';

import 'profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  final UserProfileRepo repo;

  UserProfileCubit(this.repo) : super(UserProfileInitial());

  void fetchProfile() async {
    emit(UserAccountLoading());
    try {
      final profile = await repo.getCurrentUser();
      emit(UserProfileSuccess(profile));
    } catch (e) {
      emit(UserProfileFailure(e.toString()));
    }
  }


}
