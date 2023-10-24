// ignore_for_file: file_names

import 'package:chat/Bloc/Register/RegisterCubit.dart';
import 'package:chat/Bloc/Register/RegisterState.dart';
import 'package:chat/Layout/layoutScreen.dart';
import 'package:chat/Widget/constant.dart';
import 'package:chat/Widget/custtomTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
        listener: (BuildContext context, RegisterState state) {
      if (state is CreateUserSuccessState) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (builder) {
          return const SocialLayout();
        }));
      }
    }, builder: (BuildContext context, RegisterState state) {
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: SingleChildScrollView(
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
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  color: colorCardTextFromField,
                  child: defaultFormText(
                    controller: nameController,
                    type: TextInputType.text,
                    hintText: 'Name',
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Name Can not be Empty';
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
                    isPassword: RegisterCubit.get(context).showPassword,
                    suffixClicked: () {
                      RegisterCubit.get(context).changePasswordVisibility();
                    },
                    suffix: RegisterCubit.get(context).suffix,
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
                  height: 25,
                ),
                Card(
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  color: colorCardTextFromField,
                  child: defaultFormText(
                    controller: phoneController,
                    type: TextInputType.phone,
                    hintText: 'Phone',
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Phone Can not be Empty';
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
                  if (state is! RegisterLoadingState) {
                    return defaultButton(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          RegisterCubit.get(context).userRegister(
                            name: nameController.text,
                            email: emailController.text,
                            password: passwordController.text,
                            phone: phoneController.text,
                          );
                        }
                      },
                      text: 'Sign Up',
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
                  child: Row(
                    children: [
                      const Text(
                        'You have an account?',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 22,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Sign in!',
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
              ],
            ),
          ),
        ),
      );
    });
  }
}
