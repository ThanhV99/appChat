import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'Widget/bezierContainer.dart';

import 'controller.dart';

class LoginScreen extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
          child: Container(
            height: size.height,
            child: Stack(
              children: [
                // Positioned(
                //     top: 40,
                //     left: 0,
                //     child: InkWell(
                //       onTap: (){
                //         Navigator.pop(context);
                //       },
                //       child: Container(
                //         child: Row(
                //           children: const [
                //             Icon(Icons.keyboard_arrow_left),
                //             Text(
                //               "Quay lại",
                //               style: TextStyle(
                //                 fontSize: 15,
                //                 fontWeight: FontWeight.w500,
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //     )
                // ),
                Positioned(
                  top: -size.height * .15,
                  right: -MediaQuery.of(context).size.width * .4,
                  child: BezierContainer(),
                ),
                controller.isloading.value ? Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor)) :
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
                          key: controller.formKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                                      onSaved: (val){
                                        controller.email = val!;
                                      },
                                      validator: (val){
                                        return controller.validateEmail(val!);
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
                                    )
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
                                      onSaved: (val){
                                        controller.password.value = val!;
                                      },
                                      validator: (val){
                                        return controller.validatePassword(val!);
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
                                    )
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
                              controller.login();
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
                                    controller.handleSignup();
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
