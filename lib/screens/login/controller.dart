import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../helper/helper_function.dart';
import '../../service/auth_service.dart';
import '../../service/database_service.dart';

class LoginController extends GetxController{
  var isloading = false.obs;
  var isSignedIn = false.obs;
  final formKey = GlobalKey<FormState>();
  var email = "";
  var password = "".obs;
  AuthService authService = AuthService();

  @override
  void onInit(){
    super.onInit();
    getUserLoggedInStatus();
  }

  getUserLoggedInStatus() async{
    await HelperFunctions.getUserLoggedInStatus().then((value) {
      if (value!=null){
        isSignedIn.value = value;
      }
    });
  }

  String? validateEmail(String value){
    if(value.length <= 0){
      return "Email không được để trống";
    }else{
      return null;
    }
  }

  String? validatePassword(String value){
    if(value.length<=6){
      return "Mật khẩu phải có ít nhất 6 kí tự";
    }else{
      return null;
    }
  }

  login() async{
    if(formKey.currentState!.validate()){
      formKey.currentState!.save();
      isloading.value = true;
      await authService.loginUserWithEmailAndPassword(email, password.value).then((value) async{
        if (value == true){
          QuerySnapshot snapshot = await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid).gettingUserData(email);
          await HelperFunctions.saveUserLoggedInStatus(true);
          await HelperFunctions.saveUserEmailSF(email);
          await HelperFunctions.saveUserNameSF(snapshot.docs[0]['fullName']);
          // next screen
          handleChats();
        } else {
          showSnackBar();
          isloading.value = false;
        }
      });
    }
  }

  showSnackBar(){
    Get.snackbar("Lỗi đăng nhập", "Tài khoản hoặc mật khẩu không đúng",
        snackPosition: SnackPosition.BOTTOM,
        // colorText: Colors.white,
        // backgroundColor: Colors.red
    );
  }

  handleChats(){
    Get.offAndToNamed("/chats");
  }

  handleSignup(){
    Get.toNamed("/signup");
  }
}