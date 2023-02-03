import 'package:appchat/helper/helper_function.dart';
import 'package:appchat/screens/chats/chats_screen.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import '../loginOrSignUp/login_signup.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int index_page = 0;
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
        child: SizedBox(
          width: 360.w,
          height: 720.h,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              PageView(
                scrollDirection: Axis.horizontal,
                reverse: false,
                onPageChanged: (index){
                  setState(() {
                    index_page = index;
                  });
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
                  position: index_page.toDouble(),
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
        )
          // child: Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     const Spacer(flex: 2),
          //     Image.asset("assets/images/welcome_image.png"),
          //     Text(
          //       "Welcome to our freedom \nmessage app",
          //       textAlign: TextAlign.center,
          //       style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
          //     ),
          //     const Spacer(),
          //     FittedBox(
          //       child: TextButton(
          //         onPressed: (){
          //           if (_isSignedIn) {
          //             Navigator.pushReplacement(context, MaterialPageRoute(
          //                 builder: (context) => const ChatsScreen()));
          //           }else{
          //             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginOrSignUpScreen()));
          //           }
          //         },
          //         child: Row(
          //           children: [
          //             Text(
          //               "Skip",
          //               style: Theme.of(context).textTheme.bodyLarge!.copyWith(
          //                   color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.8)
          //               ),
          //             ),
          //             const SizedBox(width: 10),
          //             Icon(
          //               Icons.arrow_forward,
          //               size: 16,
          //               color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.8),
          //             )
          //           ],
          //         ),
          //       ),
          //     ),
          //   ],
          // )
      ),
    );
  }
}