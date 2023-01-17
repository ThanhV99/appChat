import 'package:appchat/screens/chats/chats_screen.dart';
import 'package:appchat/service/auth_service.dart';
import 'package:flutter/material.dart';

import '../login/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  String userName;
  String email;
  ProfileScreen({Key? key, required this.userName, required this.email}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Thông tin"),
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
              widget.userName,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15,),
            const Divider(height: 2,),
            ListTile(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (_) => ChatsScreen()));
              },
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: Icon(Icons.group),
              title: Text("Nhóm"),
            ),
            ListTile(
              onTap: (){},
              selectedColor: Theme.of(context).primaryColor,
              selected: true,
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
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.account_circle,
              size: 200,
            ),
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Tên hiển thị"),
                Text(widget.userName)
              ],
            ),
            Divider(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Email"),
                Text(widget.email)
              ],
            )
          ],
        ),
      ),
    );
  }
}
