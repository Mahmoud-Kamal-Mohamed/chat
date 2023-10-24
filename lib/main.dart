import 'package:chat/Bloc/Chats/ChatsCubit.dart';
import 'package:chat/Bloc/Chats/ChatsState.dart';
import 'package:chat/Bloc/Login/LoginCubit.dart';
import 'package:chat/Bloc/Register/RegisterCubit.dart';
import 'package:chat/Helper/moodHelper.dart';
import 'package:chat/Layout/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  CacheHelper.init();
  runApp(const MyApp());
}

var uid = CacheHelper.getData(key: 'uid');

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => RegisterCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => SocialCubit(SocialInitial())
            ..getUserData()
            ..userModel
            ..getAllUsers(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.grey,
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
              type: BottomNavigationBarType.fixed,
              elevation: 30,
              backgroundColor: Colors.grey[800],
              selectedItemColor: Colors.blue,
              unselectedItemColor: Colors.white),
          scaffoldBackgroundColor: Colors.white,
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Colors.blue,
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.grey[800],
            titleSpacing: 20,
            elevation: 0.0,
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          textTheme: const TextTheme(
            bodyLarge: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
        home: const Splashscreen(),
      ),
    );
  }
}
