
abstract class LoginState {}

final class LoginInitial extends LoginState {}

class ChangePasswordVisibility extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  late final String uid;
  LoginSuccessState(this.uid);
}

class LoginErrorState extends LoginState {
  late final String error;
  LoginErrorState(this.error);
}

