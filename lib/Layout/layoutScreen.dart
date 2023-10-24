import 'package:chat/Bloc/Chats/ChatsCubit.dart';
import 'package:chat/Bloc/Chats/ChatsState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SocialCubit.get(context);
          for (var v = 0; v < 0; v++) {
            cubit.getUserData();
          }
          return Scaffold(
            backgroundColor: Colors.grey[800],
            appBar: AppBar(
              title: Text(
                cubit.titles[cubit.currentIndex],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.notifications)),
                IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
                onTap: (index) {
                  cubit.changeNavigationBarState(index);
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'User',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    label: 'Settings',
                  ),
                ],
                currentIndex: cubit.currentIndex),
          );
        });
  }
}
