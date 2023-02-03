import 'package:appchat/screens/chats/bindings.dart';
import 'package:appchat/screens/chats/view.dart';
import 'package:appchat/screens/login/bindings.dart';
import 'package:appchat/screens/login/view.dart';
import 'package:appchat/screens/signup/bindings.dart';
import 'package:appchat/screens/signup/view.dart';
import 'package:appchat/screens/welcome/bindings.dart';
import 'package:appchat/screens/welcome/view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/main.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (BuildContext context, Widget? child) => GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.light(),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: "/welcome",
        initialBinding: WelcomeBinding(),
        getPages: [
          GetPage(
            name: "/welcome",
            page: () => WelcomeScreen(),
            binding: WelcomeBinding(),
          ),
          GetPage(
            name: "/login",
            page: () => LoginScreen(),
            binding: LoginBinding(),
          ),
          GetPage(
            name: "/signup",
            page: () => SignUpScreen(),
            binding: SignupBinding(),
          ),
          GetPage(
            name: "/chats",
            page: () => ChatsScreen(),
            binding: ChatsBinding(),
          ),
        ],
      )
    );
  }
}