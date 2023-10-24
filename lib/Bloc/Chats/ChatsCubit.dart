import 'dart:io';

import 'package:chat/Bloc/Chats/ChatsState.dart';
import 'package:chat/Models/messageModel.dart';
import 'package:chat/Models/userModel.dart';
import 'package:chat/Settings/SettingsScreen.dart';
import 'package:chat/Users/All_Users.dart';
import 'package:chat/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class SocialCubit extends Cubit<SocialState> {
  SocialCubit(SocialInitial socialInitial) : super(SocialInitial());

  static SocialCubit get(context) => BlocProvider.of(context);

  ///////////////////////////////////////////////////////////////////////

  int currentIndex = 0;
  List<Widget> screens = [
    const UsersScreen(),
    const SettingsScreen(),
  ];
  List<String> titles = [
    'Users',
    'Settings',
  ];

  void changeNavigationBarState(int index) {
    if (index == 0) {
      getAllUsers();
    }
    currentIndex = index;
    emit(SocialChangeNavigationBar());
  }

  ///////////////////////////////////////////////////////////////////////
  UserModel? userModel;

  void getUserData() {
    emit(SocialGetUserDataLoading());
    FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
      userModel = UserModel.fromJson(value.data()!);
      print(userModel!.name);
      emit(SocialGetUserDataSuccess());
    }).catchError((onError) {
      print(onError.toString());
      emit(SocialGetUserDataError(onError.toString()));
    });
  }

  void updateUserData({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? image,
  }) {
    emit(SocialUpdateUserDataLoading());
    UserModel model = UserModel(
      name: name,
      phone: phone,
      bio: bio,
      image: image ?? userModel!.image,
      email: userModel!.email,
      uid: userModel!.uid,
      coverImage: cover ?? userModel!.coverImage,
      isEmailVerified: userModel!.isEmailVerified,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uid)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((onError) {
      emit(SocialUpdateUserDataError(onError.toString()));
    });
  }

  ///////////////////////////////////////////////////////////////////////
  // ProfileImage
  File? profileImageFile;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickerFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickerFile != null) {
      profileImageFile = File(pickerFile.path);
      emit(SocialProfileImagePickerSuccessState());
    } else {
      print('No Image selected!!!');
      emit(SocialProfileImagePickerErrorState());
    }
  }

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUpdateProfileImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImageFile!.path).pathSegments.last}')
        .putFile(profileImageFile!)
        .then((value) {
      value.ref.getDownloadURL().then(
        (value) {
          updateUserData(
            name: name,
            phone: phone,
            bio: bio,
            image: value,
          );
          // emit(SocialUpdateProfileImageSuccessState());
          print(value);
        },
      ).catchError((onError) {
        emit(SocialUpdateCoverImageErrorState());
        print(onError.toString());
      });
    }).catchError((onError) {
      emit(SocialUpdateProfileImageErrorState());
      print(onError.toString());
    });
  }

  /////////////////////////////////////////////////////////////////////////
  // CoverImage
  File? coverImageFile;

  Future<void> getCoverImage() async {
    emit(SocialCoverImagePickerLoadingState());
    final pickerFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickerFile != null) {
      coverImageFile = File(pickerFile.path);
      emit(SocialCoverImagePickerSuccessState());
      print(coverImageFile);
    } else {
      print('No Image selected!!!');
      emit(SocialCoverImagePickerErrorState());
    }
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUpdateCoverImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImageFile!.path).pathSegments.last}')
        .putFile(coverImageFile!)
        .then((value) {
      value.ref.getDownloadURL().then(
        (value) {
          updateUserData(
            name: name,
            phone: phone,
            bio: bio,
            cover: value,
          );
          // emit(SocialUpdateCoverImageSuccessState());
          print(value);
        },
      ).catchError((onError) {
        emit(SocialUpdateCoverImageErrorState());
        print(onError.toString());
      });
    }).catchError((onError) {
      emit(SocialUpdateCoverImageErrorState());
      print(onError.toString());
    });
  }

  ///////////////////////////////////////////////////////////////////////
  // Chat => getAllUsers  ||  sendMessage ||  getMessages
  List<UserModel> getAllUsersModel = [];

  void getAllUsers() {
    getAllUsersModel.clear();
    emit(SocialGetAllUsersLoading());
    FirebaseFirestore.instance.collection('users').get().then((value) {
      for (var element in value.docs) {
        if (element.data()['uid'] != userModel!.uid) {
          getAllUsersModel.add(UserModel.fromJson(element.data()));
        }
        emit(SocialGetAllUsersSuccess());
      }
      emit(SocialGetAllUsersSuccess());
    }).catchError((error) {
      emit(SocialGetAllUsersError(error.toString()));
      print(error);
    });
  }

  void sendMessage({
    String? receiverId,
    String? text,
    String? dateTime,
    String? image,
  }) {
    MessageModel messageModel = MessageModel(
      text: text,
      senderID: userModel!.uid,
      dateTime: dateTime,
      image: image,
      receiverId: receiverId,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
      print(text);
    }).catchError((onError) {
      emit(SocialSendMessageErrorState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uid)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
      print(text);
    }).catchError((onError) {
      emit(SocialSendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];

  void getMessages({required String receiverId}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages.clear();
      for (var element in event.docs) {
        messages.add(MessageModel.fromJson(element.data()));
      }
      emit(SocialGetMessageSuccessState());
    });
  }
}
