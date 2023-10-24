import 'package:chat/Bloc/Chats/ChatsCubit.dart';
import 'package:chat/Bloc/Chats/ChatsState.dart';
import 'package:chat/Widget/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileUserScreen extends StatelessWidget {
  const EditProfileUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        var user = SocialCubit.get(context).userModel!;
        var editProfileImage = SocialCubit.get(context).profileImageFile;
        var editCoverImage = SocialCubit.get(context).coverImageFile;

        nameController.text = user.name!;
        phoneController.text = user.phone!;
        bioController.text = user.bio!;
        return Scaffold(
          backgroundColor: Colors.grey[800],
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            titleSpacing: 0.0,
            title: const Text(
              'Edit Profile',
              style: TextStyle(
                fontSize: 25,
                color: Colors.white54,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: TextButton(
                  onPressed: () {
                    SocialCubit.get(context).updateUserData(
                      name: nameController.text,
                      phone: phoneController.text,
                      bio: bioController.text,
                    );
                  },
                  child: const Text(
                    'Update',
                    style: TextStyle(color: Colors.black, fontSize: 22),
                  ),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                if (state is SocialUpdateUserDataLoading)
                  const LinearProgressIndicator(),
                if (state is! SocialUpdateUserDataLoading)
                  const SizedBox(
                    height: 15,
                  ),
                Stack(
                  alignment: Alignment.bottomCenter,
                  clipBehavior: Clip.none,
                  children: [
                    Stack(
                      alignment: Alignment.topRight,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      children: [
                        SizedBox(
                            width: double.infinity,
                            child: Card(
                              margin: const EdgeInsets.all(8.0),
                              elevation: 5,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Image(
                                image: editCoverImage == null
                                    ? NetworkImage('${user.coverImage}')
                                    : FileImage(editCoverImage)
                                        as ImageProvider,
                                fit: BoxFit.cover,
                                height: 200,
                              ),
                            )),
                        Positioned(
                          top: 14,
                          right: 10,
                          child: IconButton(
                            onPressed: () {
                              SocialCubit.get(context).getCoverImage();
                              print('object');
                            },
                            icon: const Icon(
                              Icons.camera_alt_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      top: 150,
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 64,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              backgroundImage: editProfileImage == null
                                  ? NetworkImage('${user.image}')
                                  : FileImage(editProfileImage)
                                      as ImageProvider,
                              radius: 60,
                            ),
                          ),
                          Positioned(
                            top: 14,
                            right: 4,
                            child: IconButton(
                              onPressed: () {
                                SocialCubit.get(context).getProfileImage();
                                print('object');
                              },
                              icon: const Icon(
                                Icons.camera_alt_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 64,
                ),
                if (SocialCubit.get(context).coverImageFile != null ||
                    SocialCubit.get(context).profileImageFile != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        if (SocialCubit.get(context).profileImageFile != null)
                          Expanded(
                            child: OutlinedButton(
                                onPressed: () {
                                  SocialCubit.get(context).uploadProfileImage(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    bio: bioController.text,
                                  );
                                  print('$editProfileImage');
                                },
                                child: const Text(
                                  'Update Profile Image',
                                  style: TextStyle(
                                    color: Colors.white54,
                                  ),
                                )),
                          ),
                        const SizedBox(
                          width: 5,
                        ),
                        if (SocialCubit.get(context).coverImageFile != null)
                          Expanded(
                            child: OutlinedButton(
                                onPressed: () {
                                  SocialCubit.get(context).uploadCoverImage(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    bio: bioController.text,
                                  );
                                },
                                child: const Text(
                                  'Update Cover Image',
                                  style: TextStyle(
                                    color: Colors.white54,
                                  ),
                                )),
                          ),
                      ],
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: textFieldProfile(
                    controller: nameController,
                    type: TextInputType.name,
                    prefix: Icons.person_2,
                    label: 'Name',
                    hintText: '${user.name}',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: textFieldProfile(
                    controller: bioController,
                    type: TextInputType.text,
                    prefix: Icons.info_outline,
                    label: 'Bio',
                    hintText: '${user.bio}',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: textFieldProfile(
                    controller: phoneController,
                    type: TextInputType.phone,
                    prefix: Icons.phone,
                    label: 'Phone',
                    hintText: '${user.phone}',
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget textFieldProfile({
  required TextEditingController controller,
  required TextInputType type,
  dynamic validator,
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
        border: const OutlineInputBorder(),
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
