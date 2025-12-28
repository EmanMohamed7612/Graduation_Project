part of 'auth_cubit.dart';

//@immutable
sealed class AuthState {}

final class AuthInitialState extends AuthState {}

final class LoginLoadingState extends AuthState {}

final class LoginSuccessState extends AuthState {}

final class LoginFailureState extends AuthState {
  final String errorMessage;
  LoginFailureState(this.errorMessage);
}

final class SignLoadingState extends AuthState {}

final class SignSuccessState extends AuthState {
  final String message;
  SignSuccessState({ required this.message});
}

final class SignFailureState extends AuthState {
  final String errorMessage;
  SignFailureState({required this.errorMessage});
}
