import 'package:appchat/screens/welcome/state.dart';
import 'package:get/get.dart';

import '../../helper/helper_function.dart';

class WelcomeController extends GetxController{
  final state = WelcomeState();

  @override
  void onInit(){
    super.onInit();
    getUserLoggedInStatus();
  }

  getUserLoggedInStatus() async {
    await HelperFunctions.getUserLoggedInStatus().then((value){
      if(value!=null){
        state.isSignedIn.value = value;
      }
    });
  }

  changePage(int index) async{
    state.index.value = index;
  }

  handleLogin() async{
    Get.offAndToNamed("/login");
  }

  handleChats(){
    Get.offAndToNamed("/chats");
  }
}