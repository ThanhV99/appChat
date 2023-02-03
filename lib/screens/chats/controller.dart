import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helper/helper_function.dart';
import '../../service/auth_service.dart';
import '../../service/database_service.dart';

class ChatsController extends GetxController{
  late String search;
  final formKey = GlobalKey<FormState>();
  AuthService authService = AuthService();
  String userName = "";
  String email = "";
  Stream? groups;

  @override
  void onInit(){
    super.onInit();
    gettingUserData();
  }

  gettingUserData() async{
    await HelperFunctions.getUserEmailFromSF().then((value){
      email = value!;
    });
    await HelperFunctions.getUserNameFromSF().then((value){
      userName = value!;
    });
    await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid).getUserGroups().then((snapshot){
      groups = snapshot!;
    });
  }

  handleSignOut(){
    authService.signOut().whenComplete((){
      Get.offAllNamed("/login");
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
    });
  }
}