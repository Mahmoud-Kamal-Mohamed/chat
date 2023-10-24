import 'package:chat/Bloc/Chats/ChatsCubit.dart';
import 'package:chat/Bloc/Chats/ChatsState.dart';
import 'package:chat/Models/userModel.dart';
import 'package:chat/Screens/chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (SocialCubit.get(context).getAllUsersModel.isNotEmpty) {
          return ListView.separated(
            itemBuilder: (context, index) => buildChatItem(
                SocialCubit.get(context).getAllUsersModel[index], context),
            separatorBuilder: (context, index) => const SizedBox(),
            itemCount: SocialCubit.get(context).getAllUsersModel.length,
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

Widget buildChatItem(UserModel model, context) => InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (builder) => ChatsDetailsScreen(
              userModel: model,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundImage: NetworkImage('${model.image}'),
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              '${model.name}',
              style: const TextStyle(
                height: 1.4,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
