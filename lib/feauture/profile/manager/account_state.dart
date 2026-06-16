// import 'package:graduation2/feauture/profile/data/user_account_model.dart';
// import 'package:graduation2/feauture/profile/data/user_profile_model.dart';

// abstract class UserAccountState {}

// class UserAccountInitial extends UserAccountState {}
// class UserAccountLoading extends UserAccountState {}
// class UserAccountSuccess extends UserAccountState {
//   final UserAccountModel profile;
//   UserAccountSuccess(this.profile);
// }
// class UserAccountFailure extends UserAccountState {
//   final String message;
//   UserAccountFailure(this.message);
// }





import 'package:graduation2/feauture/profile/data/user_account_model.dart';

abstract class AccountState {}

class AccountInitial extends AccountState {}

class AccountLoading extends AccountState {}

class AccountSuccess extends AccountState {
  final UserAccountModel user;
  AccountSuccess(this.user);
}

class AccountFailure extends AccountState {
  final String message;
  AccountFailure(this.message);
}