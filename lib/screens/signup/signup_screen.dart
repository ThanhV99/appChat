import 'package:appchat/helper/helper_function.dart';
import 'package:appchat/screens/login/login_screen.dart';
import 'package:appchat/service/auth_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Widget/bezierContainer.dart';
import '../chats/chats_screen.dart';
import 'Widget/snackBar.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isloading = false;
  final formKey = GlobalKey<FormState>();
  String fullName = "";
  String email = "";
  String password = "";
  AuthService authService = AuthService();

  register() async {
    if(formKey.currentState!.validate()){
      setState(() {
        _isloading = true;
      });
      await authService.registerUserWithEmailAndPassword(fullName, email, password).then((value) async{
        if (value == true){
          // saving the shared preference state
          await HelperFunctions.saveUserLoggedInStatus(true);
          await HelperFunctions.saveUserNameSF(fullName);
          await HelperFunctions.saveUserEmailSF(email);
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
                        children: [
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
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: size.height * .2),
                          const SizedBox(height: 20),
                          Column(
                              children: <Widget>[
                                const SizedBox(height: 80),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      const Text(
                                        "Tên hiển thị",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      TextFormField(
                                        onChanged: (val){
                                          setState(() {
                                            fullName = val;
                                          });
                                        },
                                        validator: (val){
                                          return (val!.isEmpty) ? "Tên không được để trống" : null;
                                        },
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          suffixIcon: const Icon(Icons.person_outlined),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ]
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
                                  onChanged: (val){
                                    setState(() {
                                      email = val;
                                    });
                                  },
                                  validator: (val){
                                    return (val!.isEmpty) ? "Email không được để trống" : null;
                                  },
                                  textAlign: TextAlign.start,
                                  obscureText: false,
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
                                const SizedBox(height: 20),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: (){
                                      register();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Theme.of(context).primaryColor,
                                      elevation: 3,
                                    ),
                                    child: const Text(
                                      'Đăng Ký',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
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
                                Container(
                                  alignment: Alignment.center,
                                  child: Text.rich(TextSpan(
                                      text: "Đã có tài khoản? ",
                                      style: TextStyle(color: Colors.black, fontSize: 14),
                                      children: [
                                        TextSpan(
                                            text: "Đăng nhập ngay",
                                            style: TextStyle(
                                                color: Theme.of(context).primaryColor,
                                                fontWeight: FontWeight.w500
                                            ),
                                            recognizer: TapGestureRecognizer()..onTap = (){
                                              Navigator.pop(context);
                                            }
                                        )
                                      ]
                                  )),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  )
                )
            ],
          ),
        ),
      )
    );
  }
}
