// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:graduation2/core/services/api_services.dart';
// import 'package:graduation2/feauture/profile/manager/account_state.dart';

// import 'profile_state.dart' hide UserAccountLoading;

// class UserAccountCubit extends Cubit<UserAccountState> {
//   final UserProfileRepo repo;

//   UserAccountCubit(this.repo) : super(UserAccountInitial());

//   Future<void> fetchAccount(String userId) async {
//     emit(UserAccountLoading());
//     try {
//       final profile = await repo.getAccountUser(userId);
//       emit(UserAccountSuccess(profile));
//     } catch (e) {
//       emit(UserAccountFailure(e.toString()));
//     }
//   }
// }

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/core/services/api_services.dart';
import 'package:graduation2/feauture/profile/data/user_profile_model.dart';
import 'package:graduation2/core/services/api_error.dart';
import 'package:graduation2/feauture/profile/manager/account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  final UserProfileRepo repo;

  AccountCubit(this.repo) : super(AccountInitial());

  Future<void> fetchAccount(String userId) async {
    emit(AccountLoading());

    try {
      final user = await repo.getAccountById(userId);
      emit(AccountSuccess(user));
    } catch (e) {
      if (e is ApiError) {
        emit(AccountFailure(e.message));
      } else {
        emit(AccountFailure('Unexpected error'));
      }
    }
  }
}
