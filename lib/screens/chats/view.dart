import 'package:appchat/helper/helper_function.dart';
import 'package:appchat/screens/chats/controller.dart';
import 'package:appchat/screens/login/login_screen.dart';
import 'package:appchat/screens/profile/profile_screen.dart';
import 'package:appchat/service/auth_service.dart';
import 'package:appchat/service/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:get/get.dart';

class ChatsScreen extends GetView<ChatsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat"),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 50),
          children: [
            Icon(
              Icons.account_circle,
              size: 150,
              color: Colors.grey[700],
            ),
            const SizedBox(height: 15,),
            Text(
              controller.userName,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15,),
            const Divider(height: 2,),
            ListTile(
              onTap: (){},
              selectedColor: Theme.of(context).primaryColor,
              selected: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: Icon(Icons.group),
              title: Text("Nhóm"),
            ),
            ListTile(
              onTap: (){
                ////////////////////////////////////////////////////////////////
                // Navigator.push(context, MaterialPageRoute(builder: (_) => ProfileScreen(userName: controller.userName, email: con)));
              },
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: Icon(Icons.group),
              title: Text("Thông tin"),
            ),
            ListTile(
              onTap: () async{
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context){
                      return AlertDialog(
                        title: const Text("Thông báo"),
                        content: const Text("Bạn chắc chắn thoát?"),
                        actions: [
                          IconButton(
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.cancel, color: Colors.red)
                          ),
                          IconButton(
                              onPressed: (){
                                controller.handleSignOut();
                              },
                              icon: const Icon(Icons.done, color: Colors.green)
                          )
                        ],
                      );
                    }
                );
              },
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon(Icons.exit_to_app),
              title: const Text("Thoát"),
            )
          ],
        ),
      ),
      body: groupList(),
    );
  }

  groupList(){
    return StreamBuilder(
      stream: controller.groups,
      builder: (context, AsyncSnapshot snapshot){
        if (snapshot.hasData){
          if(snapshot.data['groups'] != null){
            if(snapshot.data['groups'].length != 0){
              return Text("sdfg");
            } else{
              return noGroupWidget();
            }
          } else{
            return noGroupWidget();
          }
        }else{
          return Center(
            child: CircularProgressIndicator(color: Theme.of(context).primaryColor),
          );
        }
      },
    );
  }

  noGroupWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Get.defaultDialog(
                  title: "GetX Dialog",
                  content: Column(
                    children: [
                      Text("Line 1"),
                      Text("Line 2")
                    ],
                  )
              );
            },
            child: Icon(
              Icons.add_circle,
              color: Colors.grey[700],
              size: 75,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "You've not joined any groups, tap on the add icon to create a group or also search from top search button.",
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
