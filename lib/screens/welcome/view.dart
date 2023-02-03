import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'controller.dart';


class WelcomeScreen extends GetView<WelcomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() => SizedBox(
          width: 360.w,
          height: 720.h,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              PageView(
                scrollDirection: Axis.horizontal,
                reverse: false,
                onPageChanged: (index){
                  controller.changePage(index);
                },
                controller: PageController(
                    initialPage: 0, keepPage: false, viewportFraction: 1
                ),
                pageSnapping: true,
                physics: ClampingScrollPhysics(),
                children: [
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage("assets/images/welcome_image.png")
                        )
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage("assets/images/welcome_image.png")
                        )
                    ),
                  ),
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage("assets/images/welcome_image.png")
                        )
                    ),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Positioned(
                          bottom: 50,
                          child: FittedBox(
                            child: TextButton(
                              onPressed: (){
                                if (controller.state.isSignedIn.value) {
                                  controller.handleChats();
                                }else{
                                  controller.handleLogin();
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
                          )
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 90,
                child: DotsIndicator(
                  position: controller.state.index.value.toDouble(),
                  dotsCount: 3,
                  reversed: false,
                  mainAxisAlignment: MainAxisAlignment.center,
                  decorator: DotsDecorator(
                    size: const Size.square(9),
                    activeSize: const Size(18, 9),
                    activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)
                    )
                  ),
                ),
              )
            ],
          ),
        ))
      ),
    );
  }
}