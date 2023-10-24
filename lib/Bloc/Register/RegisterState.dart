abstract class RegisterState {}

final class RegisterInitial extends RegisterState {}

class ChangePasswordVisibility extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterSuccessState extends RegisterState {
  late final String uid;
  RegisterSuccessState(this.uid);
}

class RegisterErrorState extends RegisterState {
  late final String error;
  RegisterErrorState(this.error);
}

class CreateUserLoadingState extends RegisterState {}

class CreateUserSuccessState extends RegisterState {}

class CreateUserErrorState extends RegisterState {
  late final String error;
  CreateUserErrorState(this.error);
}
