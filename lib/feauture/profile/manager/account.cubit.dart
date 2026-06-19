

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/core/services/api_services.dart';
import 'package:graduation2/core/services/api_error.dart';
import 'package:graduation2/feauture/profile/data/user_profile_repo.dart';
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
