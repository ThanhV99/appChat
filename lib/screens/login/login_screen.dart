import 'package:appchat/helper/helper_function.dart';
import 'package:appchat/service/auth_service.dart';
import 'package:appchat/service/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../chats/chats_screen.dart';
import '../signup/Widget/snackBar.dart';
import '../signup/signup_screen.dart';
import 'Widget/bezierContainer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isSignedIn = false;
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  bool _isloading = false;
  AuthService authService = AuthService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserLoggedInStatus();
  }

  getUserLoggedInStatus() async{
    await HelperFunctions.getUserLoggedInStatus().then((value) {
      if (value!=null){
        _isSignedIn = value;
      }
    });
  }

  void validateAndSave(){
    final FormState? form = formKey.currentState;
    if(form!.validate()){
      if(_isSignedIn){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ChatsScreen()));
      }
    }
  }

  login() async{
    if(formKey.currentState!.validate()){
      setState(() {
        _isloading = true;
      });
      await authService.loginUserWithEmailAndPassword(email, password).then((value) async{
        if (value == true){
          QuerySnapshot snapshot = await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid).gettingUserData(email);
          await HelperFunctions.saveUserLoggedInStatus(true);
          await HelperFunctions.saveUserEmailSF(email);
          await HelperFunctions.saveUserNameSF(snapshot.docs[0]['fullName']);
          // next screen
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ChatsScreen()));
        } else {
          showSnackBar(context, value, Colors.red);
          setState(() {
            _isloading = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: size.height,
          child: Stack(
            children: [
              Positioned(
                top: 40,
                left: 0,
                child: InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    child: Row(
                      children: const [
                        Icon(Icons.keyboard_arrow_left),
                        Text(
                          "Quay lại",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ),
              Positioned(
                top: -size.height * .15,
                right: -MediaQuery.of(context).size.width * .4,
                child: BezierContainer(),
              ),
              _isloading ? Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor)) :
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: size.height * .2),
                        RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(
                            text: 'T',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              color: Colors.purpleAccent,
                            ),
                            children: [
                              TextSpan(
                                text: 'al',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 30,
                                ),
                              ),
                              TextSpan(
                                text: 'k',
                                style: TextStyle(
                                  color: Colors.purpleAccent,
                                  fontSize: 30,
                                ),
                              ),
                              TextSpan(
                                text: 'lin',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 30,
                                ),
                              ),
                              TextSpan(
                                text: 'e',
                                style: TextStyle(
                                  color: Colors.purpleAccent,
                                  fontSize: 30,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Form(
                          key: formKey,
                          child: Column(
                            children: <Widget>[
                              const SizedBox(
                                height: 80,
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const Text(
                                      "Email",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      style: const TextStyle(
                                        fontSize: 20,
                                      ),
                                      textAlign: TextAlign.start,
                                      obscureText: false,
                                      onChanged: (val){
                                        setState(() {
                                          email = val;
                                        });
                                      },
                                      validator: (val){
                                        return (val!.isNotEmpty) ? null : "Email không được để trống";
                                      },
                                      decoration: InputDecoration(
                                        suffixIcon: const Icon(
                                          Icons.email_outlined,
                                          color: Colors.black54,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const Text(
                                      "Mật khẩu",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    TextFormField(
                                      obscureText: true,
                                      onChanged: (val){
                                        setState(() {
                                          password = val;
                                        });
                                      },
                                      validator: (val){
                                        return (val!.length < 6) ? "Mật khẩu phải có ít nhất 6 kí tự" : null;
                                      },
                                      decoration: InputDecoration(
                                        suffixIcon: const Icon(
                                          Icons.visibility,
                                          color: Colors.black54,
                                        ),
                                        // icon: Icon(Icons.lock),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: (){
                              login();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              elevation: 3,
                            ),
                            child: const Text(
                              'Đăng nhập',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.centerRight,
                          child: const Text(
                            'Quên mật khẩu?',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Divider(
                              thickness: 1,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text.rich(TextSpan(
                          text: "Chưa có tài khoản? ",
                          style: TextStyle(color: Colors.black, fontSize: 14),
                          children: [
                            TextSpan(
                              text: "Đăng ký",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w500
                              ),
                              recognizer: TapGestureRecognizer()..onTap = (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignUpScreen(),
                                  ),
                                );
                              }
                            )
                          ]
                        ))
                      ],
                    ),
                  ),
                )
            ],
          ),
        ),
      )
    );
  }
}
