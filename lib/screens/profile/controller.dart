import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'package:appchat/screens/profile/state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helper/helper_function.dart';
import '../../service/auth_service.dart';
import '../../service/database_service.dart';

import '../chats/state.dart';

class ProfileController extends GetxController{
  AuthService authService = AuthService();
  final ProfileState state = ProfileState();
  final ApplicationState applicationState = ApplicationState();
  late File imageFile;

  @override
  void onInit(){
    super.onInit();
    asyncLoadAllData();
  }

  void selectImage(ImageSource source) async{

  }

  asyncLoadAllData() async{
    state.email.value = (await HelperFunctions.getUserEmailFromSF())!;
    state.fullName.value = (await HelperFunctions.getUserNameFromSF())!;
    QuerySnapshot snapshot = await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid).gettingUserData(state.email.value);
    // state.email.value = snapshot.docs[0]['email'];
    // state.fullName.value = snapshot.docs[0]['fullName'];
    // state.groups.value = snapshot.docs[0]['groups'];
    // state.uid.value = snapshot.docs[0]['uid'];
    state.profilePic.value = snapshot.docs[0]['profilePic'];
  }

  handleLogOut(){
    Get.defaultDialog(
      title: "Thông báo",
      content: Text("Bạn muốn thoát không?"),
      actions: [
        TextButton(
          onPressed: (){
            authService.signOut().whenComplete((){
              applicationState.page = 0;
              Get.offAndToNamed("/login");
            });
          },
          child: const Text("Có"),
        ),
        TextButton(
          onPressed: (){
            Get.back();
          },
          child: const Text("Không"),
        ),
      ]
    );
  }
}