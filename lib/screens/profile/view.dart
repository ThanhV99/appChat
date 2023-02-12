import 'package:appchat/screens/profile/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Container(
                      width: size.width*0.4,
                      height: size.height*0.2,
                      child: Obx(() => ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: controller.state.profilePic == null ? Placeholder()
                            : Image.network(
                          "${controller.state.profilePic}",
                          fit: BoxFit.contain,
                        ),
                      ))
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 1.0), //(x,y)
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        child: IconButton(
                          // iconSize: 20,
                          onPressed: (){
                            print("sua avatar");
                          },
                          icon: const Icon(Icons.camera_alt),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 10,),
            Flexible(
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(() => Text(controller.state.fullName.value, style: const TextStyle(fontSize: 20.0))),
                    const SizedBox(width: 10,),
                    IconButton(
                      // iconSize: 20,
                      onPressed: (){
                        print("sua ten");
                      },
                      icon: const Icon(Icons.create),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(),
            ElevatedButton(
              onPressed: (){
                controller.handleLogOut();
              },
              child: Text("Thoát"))
          ],
        ),
      )
    );
  }
}
