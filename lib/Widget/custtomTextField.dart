import 'package:flutter/material.dart';

Widget defaultFormText({
  required TextEditingController controller,
  required TextInputType type,
  required dynamic validator,
  Function? onSubmit,
  Function? onChanged,
  Function()? onTap,
  bool isPassword = false,
  String? label,
  String? hintText,
  IconData? prefix,
  IconData? suffix,
  Function()? suffixClicked,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      style: const TextStyle(
        color: Colors.grey,
        fontSize: 22,
      ),
      validator: validator,
      onFieldSubmitted: (s) {
        onSubmit!(s);
      },
      onTap: onTap,
      obscureText: isPassword,
      cursorColor: Colors.grey,
      decoration: InputDecoration(
        border: const UnderlineInputBorder(borderSide: BorderSide.none),
        suffixIconColor: const Color.fromARGB(179, 152, 151, 157),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 22,
        ),
        labelText: label,
        labelStyle: const TextStyle(
          color: Colors.grey,
        ),
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  suffixClicked!();
                },
                icon: Icon(suffix),
              )
            : null,
      ),
    );

Widget defaultButton({
  double width = 380,
  Color backGroundColor = Colors.blueGrey,
  bool isUpperCase = true,
  double radius = 30.0,
  required void Function() onTap,
  required String text,
}) =>
    Container(
        width: width,
        decoration: BoxDecoration(
            color: backGroundColor,
            borderRadius: BorderRadius.circular(radius)),
        child: MaterialButton(
          onPressed: onTap,
          child: Text(
            isUpperCase ? text.toUpperCase() : text,
            style: const TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ));
