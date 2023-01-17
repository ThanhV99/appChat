import 'package:appchat/helper/helper_function.dart';
import 'package:appchat/screens/login/login_screen.dart';
import 'package:appchat/screens/profile/profile_screen.dart';
import 'package:appchat/service/auth_service.dart';
import 'package:appchat/service/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import '../../models/Chat.dart';
import 'components/chat_card.dart';
import '../messages/message_screen.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  late String search;
  final formKey = GlobalKey<FormState>();
  AuthService authService = AuthService();
  String userName = "";
  String email = "";
  Stream? groups;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gettingUserData();
  }

  gettingUserData() async{
    await HelperFunctions.getUserEmailFromSF().then((value){
      setState(() {
        email = value!;
      });
    });
    await HelperFunctions.getUserNameFromSF().then((value){
      userName = value!;
    });
    await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid).getUserGroups().then((snapshot){
      setState(() {
        groups = snapshot;
      });
    });
  }

  groupList(){
    return StreamBuilder(
      stream: groups,
      builder: (context, snapshot){
        if (snapshot.hasData){
          if(snapshot.data['group'] != null){
            if(snapshot.data['group'].length != 0){
              return Text("sdfg");
            }
          }
        }else{
          return Center(
            child: CircularProgressIndicator(color: Theme.of(context).primaryColor),
          );
        }
      },
    );
  }

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
              userName,
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
                Navigator.push(context, MaterialPageRoute(builder: (_) => ProfileScreen(userName: userName, email: email)));
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
                            authService.signOut().whenComplete((){
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
                            });
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
      body: Material(
        child: Column(
          children: [
            Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    suffixIcon: const Padding(
                      padding: EdgeInsets.all(5),
                      child: Icon(Icons.search),
                    ),
                    hintText: "SEARCH"
                  ),
                  onSaved: (value){
                    search = value!;
                  },
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Expanded(
              child: ListView.builder(
                itemCount: chatsData.length,
                itemBuilder: (context, index){
                  return ChatCard(
                    chat: chatsData[index],
                    press: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MessagesScreen(chat: chatsData[index])));
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
