import 'package:appchat/screens/chats/state.dart';
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
  String email = "";
  Stream? groups;
  var checkdata = false.obs;
  var userName = "".obs;

  final state = ApplicationState();
  List<String> tabTitles = [];
  late final List<BottomNavigationBarItem> bottomTabs;
  PageController? pageController;

  @override
  void onInit(){
    super.onInit();
    tabTitles = ['Chat', 'Contact', 'Profile'];
    bottomTabs = const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.chat),
        label: "Tin nhắn",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.contact_page),
        label: "Liên lạc",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: "Cá nhân",
      )
    ];
    pageController = PageController(initialPage: state.page);
    gettingUserData();
  }

  @override
  void dispose(){
    pageController!.dispose();
    super.dispose();
  }

  gettingUserData() async{
    await HelperFunctions.getUserEmailFromSF().then((value){
      email = value!;
    });
    await HelperFunctions.getUserNameFromSF().then((value){
      userName.value = value!;
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

  handlePageChange(int index){
    state.page = index;
  }
  
  void handleNavBarTap(int index){
    pageController!.jumpToPage(index);
  }
}