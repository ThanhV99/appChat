import 'package:appchat/helper/helper_function.dart';
import 'package:appchat/screens/chats/chats_screen.dart';
import 'package:flutter/material.dart';
import '../loginOrSignUp/login_signup.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _isSignedIn = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("this is initstate screen welcome");
    getUserLoggedInStatus();
  }

  getUserLoggedInStatus() async {
    await HelperFunctions.getUserLoggedInStatus().then((value){
      if(value!=null){
        setState(() {
          _isSignedIn = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              Image.asset("assets/images/welcome_image.png"),
              Text(
                "Welcome to our freedom \nmessage app",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              FittedBox(
                child: TextButton(
                  onPressed: (){
                    if (_isSignedIn) {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) => const ChatsScreen()));
                    }else{
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginOrSignUpScreen()));
                    }
                  },
                  child: Row(
                    children: [
                      Text(
                        "Skip",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.8)
                        ),
                      ),
                      const SizedBox(width: 10),
                      Icon(
                        Icons.arrow_forward,
                        size: 16,
                        color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.8),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }
}