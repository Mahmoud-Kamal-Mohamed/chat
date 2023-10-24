import 'package:chat/Bloc/Chats/ChatsCubit.dart';
import 'package:chat/Bloc/Chats/ChatsState.dart';
import 'package:chat/Settings/EditProfileUserScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        var profileModel = SocialCubit.get(context).userModel;
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              SizedBox(
                height: 200,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Container(
                        height: 160,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(5),
                            topLeft: Radius.circular(5),
                          ),
                          image: DecorationImage(
                            image: NetworkImage('${profileModel!.coverImage}'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 64,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage('${profileModel.image}'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '${profileModel.name}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '${profileModel.bio}',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      child: const Text(
                        'Add Chat',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) =>
                                    const EditProfileUserScreen()));
                      },
                      child: const Icon(
                        Icons.edit,
                        size: 16,
                        color: Colors.white,
                      ))
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
