import 'package:appchat/screens/chats/controller.dart';
import 'package:appchat/screens/contact/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactScreen extends GetView<ContactController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Form(
              key: controller.formKey,
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
                        TextFormField(
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.start,
                          obscureText: false,
                          onSaved: (val){
                            controller.state.search.value = val!;
                          },
                          validator: (val){
                            // return controller.validateEmail(val!);
                          },
                          decoration: InputDecoration(
                            suffixIcon: const Icon(
                              Icons.search,
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
                ]
              ),
            ),
            ElevatedButton(
              onPressed: (){
                controller.searchUser();
              },
              child: const Text("Tìm kiếm"),
            ),

          ],
        ),

      ),
    );
  }
}
