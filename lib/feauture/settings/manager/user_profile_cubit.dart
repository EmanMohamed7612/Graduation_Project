import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/core/services/api_services.dart';
import 'package:graduation2/feauture/profile/data/user_profile_repo.dart';
import 'package:graduation2/feauture/settings/manager/user_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  final UserProfileRepo _repo;
  UpdateProfileCubit(this._repo) : super(UpdateProfileInitial());

  Future<void> updateProfile({
    required String fullName,
    String? bio,
    String? specialization,
    File? imageFile,
  }) async {
    emit(UpdateProfileLoading());
    try {
      List<String> names = fullName.split(' ');
      await _repo.updateUserProfile(
        firstName: names.isNotEmpty ? names[0] : "",
        lastName: names.length > 1 ? names.sublist(1).join(' ') : "",
        specialization: specialization,
        bio: bio,
        imageFile: imageFile,
        gender: 1,
      );
      emit(UpdateProfileSuccess());
    } catch (e) {
      // emit(UpdateProfileFailure(e.toString()));
      String errorMessage = e.toString();
      if (errorMessage.startsWith("Exception: ")) {
        errorMessage = errorMessage.replaceFirst("Exception: ", "");
      }
      emit(UpdateProfileFailure(errorMessage));
    }
  }
}
