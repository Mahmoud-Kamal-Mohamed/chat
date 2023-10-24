// ignore_for_file: must_be_immutable

import 'package:chat/Bloc/Chats/ChatsCubit.dart';
import 'package:chat/Bloc/Chats/ChatsState.dart';
import 'package:chat/Models/messageModel.dart';
import 'package:chat/Models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatsDetailsScreen extends StatelessWidget {
  UserModel userModel;
  ChatsDetailsScreen({super.key, required this.userModel});
  var messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      SocialCubit.get(context).getMessages(
        receiverId: userModel.uid!,
      );
      return BlocConsumer<SocialCubit, SocialState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              backgroundColor: Colors.grey[800],
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage('${userModel.image}'),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      '${userModel.name}',
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    )
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    if (SocialCubit.get(context).messages.isNotEmpty)
                      Expanded(
                        child: SingleChildScrollView(
                          reverse: true,
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              var message =
                                  SocialCubit.get(context).messages[index];
                              if (SocialCubit.get(context).userModel!.uid ==
                                  message.senderID) {
                                return receiveMessage(message);
                              } else {
                                return buildMessage(message);
                              }
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 15,
                            ),
                            itemCount: SocialCubit.get(context).messages.length,
                          ),
                        ),
                      ),
                    const SizedBox(
                      height: 40,
                    ),
                    if (SocialCubit.get(context).messages.isEmpty)
                      const Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: messageController,
                            onFieldSubmitted: (value) {},
                            decoration: const InputDecoration(
                                hintText: 'Type your message here...',
                                hintStyle: TextStyle(color: Colors.black),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.horizontal(
                                  right: Radius.circular(20),
                                  left: Radius.circular(20),
                                ))),
                            style: const TextStyle(),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[700],
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20))),
                          child: IconButton(
                            color: Colors.white60,
                            icon: const Icon(
                              Icons.send,
                            ),
                            iconSize: 30,
                            onPressed: () {
                              SocialCubit.get(context).sendMessage(
                                text: messageController.text,
                                receiverId: userModel.uid,
                                dateTime: DateTime.now().toLocal().toString(),
                              );
                              messageController.clear();
                            },
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          });
    });
  }
}

Widget buildMessage(MessageModel messageModel) => Align(
      alignment: AlignmentDirectional.topStart,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: const BorderRadiusDirectional.only(
            topStart: Radius.circular(10),
            bottomEnd: Radius.circular(10),
            topEnd: Radius.circular(10),
          ),
        ),
        child: Text(
          messageModel.text!,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
Widget receiveMessage(MessageModel messageModel) => Align(
      alignment: AlignmentDirectional.topEnd,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.lightBlue[200],
          borderRadius: const BorderRadiusDirectional.only(
            topStart: Radius.circular(10),
            bottomStart: Radius.circular(10),
            topEnd: Radius.circular(10),
          ),
        ),
        child: Text(
          messageModel.text!,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
