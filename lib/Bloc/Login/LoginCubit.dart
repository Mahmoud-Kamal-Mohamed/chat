import 'package:chat/Bloc/Login/LoginState.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print('Email => ${value.user!.email}');
      print('Id => ${value.user!.uid}');

      emit(LoginSuccessState(value.user!.uid));
    }).catchError((onError) {
      print(onError.toString());
      emit(LoginErrorState(onError.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool showPassword = true;
  void changePasswordVisibility() {
    showPassword = !showPassword;
    suffix = showPassword
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibility());
  }
}
