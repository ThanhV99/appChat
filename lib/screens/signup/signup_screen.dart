import 'package:appchat/screens/login/login_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Widget/bezierContainer.dart';
import '../chats/chats_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  String fullname = "";
  String phone = "";
  String password = "";

  void validateAndSave(){
    final FormState? form = formKey.currentState;
    if(form!.validate()){
      Navigator.push(context, MaterialPageRoute(builder: (context) => ChatsScreen()));
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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Form(
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
                                          fullname = val;
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
                                "Số điện thoại",
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
                                    phone = val;
                                  });
                                },
                                validator: (val){
                                  return (val!.isEmpty) ? "Số điện thoại không được để trống" : null;
                                },
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                textAlign: TextAlign.start,
                                obscureText: false,
                                decoration: InputDecoration(
                                  suffixIcon: const Icon(
                                    Icons.phone_android,
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
                                    validateAndSave();
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
