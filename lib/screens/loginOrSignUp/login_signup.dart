import 'package:appchat/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'components/change_theme_button.dart';
import '../login/login_screen.dart';
import '../signup/signup_screen.dart';

class LoginOrSignUpScreen extends StatelessWidget {
  const LoginOrSignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("WELCOME"),
        actions: const [
          ChangeThemeButtonWidget()
        ],
      ),
      body: Container(
        child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Welcome to our freedom \nmessage app",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline5!.copyWith(fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: const Text("LOGIN"),
                ),
                ElevatedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
                  },
                  child: const Text("SIGNUP"),
                )
              ],
            )
        ),
      ),
    );
  }
}
