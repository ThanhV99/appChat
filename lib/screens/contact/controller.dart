import 'package:appchat/screens/contact/state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../service/database_service.dart';

class ContactController extends GetxController{
  final ContactState state = ContactState();
  final formKey = GlobalKey<FormState>();

  searchUser() async{
    if(formKey.currentState!.validate()){
      formKey.currentState!.save();
      QuerySnapshot snapshot = await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid).searchUser(state.search.value);
      state.fullName.value = snapshot.docs[0]['fullName'];
      state.profilePic.value = snapshot.docs[0]['profilePic'];
    }
  }
}