import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../helper/helper_function.dart';
import '../../service/auth_service.dart';
import '../../service/database_service.dart';

class SignupController extends GetxController{
  var isloading = false.obs;
  final formKey = GlobalKey<FormState>();
  String fullName = "";
  String email = "";
  String password = "";
  AuthService authService = AuthService();

  String? validateName(String value){
    if(value.length <= 0){
      return "Tên không được để trống";
    }else{
      return null;
    }
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


  register() async {
    if(formKey.currentState!.validate()){
      formKey.currentState!.save();
      isloading.value = true;
      await authService.registerUserWithEmailAndPassword(fullName, email, password).then((value) async{
        if (value == true){
          // saving the shared preference state
          await HelperFunctions.saveUserLoggedInStatus(true);
          await HelperFunctions.saveUserNameSF(fullName);
          await HelperFunctions.saveUserEmailSF(email);
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

  handleLogin(){
    Get.offAllNamed("/login");
  }
}