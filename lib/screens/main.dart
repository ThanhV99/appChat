import '../responsive.dart';
import 'welcome/welcome_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: Responsive(
        // Let's work on our mobile part
        mobile: WelcomeScreen(),
        // UI cho table
        tablet: Row(
          children: [
            // Expanded(
            //   flex: 9,
            //   child: screens_page[currentIndex_page],
            // ),
            // Expanded(
            //   flex: 6,
            //   child: ScreenResult(),
            // )
          ],
        ),
        // UI cho desktop
        // desktop: InputScreen()
        desktop: Row(
          children: [
            // Expanded(
            //   flex: _size.width > 1340 ? 5 : 5,
            //   child: screens_page[currentIndex_page],
            // ),
            // Expanded(
            //   flex: _size.width > 1340 ? 5 : 5,
            //   child: const ScreenResult(),
            // )
          ],
        ),
      ),
    );
  }
}