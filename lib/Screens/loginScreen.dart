import 'package:chat/Bloc/Login/LoginCubit.dart';
import 'package:chat/Bloc/Login/LoginState.dart';
import 'package:chat/Helper/moodHelper.dart';
import 'package:chat/Layout/layoutScreen.dart';
import 'package:chat/Screens/registerScreen.dart';
import 'package:chat/Widget/constant.dart';
import 'package:chat/Widget/custtomTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (BuildContext context, LoginState state) {
        if (state is LoginSuccessState) {
          CacheHelper.saveData(key: 'uid', value: state.uid).then((value) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (builder) {
              return const SocialLayout();
            }));
          }).catchError((onError) {
            print(onError);
          });
        }
      },
      builder: (BuildContext context, LoginState state) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Social',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Card(
                      borderOnForeground: false,
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      color: colorCardTextFromField,
                      child: defaultFormText(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        hintText: 'Email',
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Email Can not be Empty';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Card(
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      color: colorCardTextFromField,
                      child: defaultFormText(
                        controller: passwordController,
                        type: TextInputType.visiblePassword,
                        hintText: 'Password',
                        isPassword: LoginCubit.get(context).showPassword,
                        suffixClicked: () {
                          LoginCubit.get(context).changePasswordVisibility();
                        },
                        onSubmit: (value) {
                          if (formKey.currentState!.validate()) {
                            LoginCubit.get(context).userLogin(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          }
                        },
                        suffix: LoginCubit.get(context).suffix,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Password Can not be Empty';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Builder(builder: (context) {
                      if (state is! LoginLoadingState) {
                        return defaultButton(
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              LoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          text: 'Sign In',
                          isUpperCase: true,
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    }),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 25),
                      child: Row(
                        children: [
                          const Text(
                            'No account?',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 22,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) =>
                                          const RegisterScreen()));
                            },
                            child: const Text(
                              'Sign up!',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 22,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        const Spacer(),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
