import 'package:appchat/screens/chats/controller.dart';
import 'package:appchat/screens/contact/view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../profile/view.dart';

class ChatsScreen extends GetView<ChatsController> {
  @override
  Widget build(BuildContext context) {
    Widget _buildPageView(){
      return PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: controller.pageController,
        onPageChanged: controller.handlePageChange,
        children: [
          Center(child: Text('chat')),
          ContactScreen(),
          ProfileScreen(),
        ],
      );
    }
    Widget _buildBottomNavigationBar(){
      return Obx(() => BottomNavigationBar(
        items: controller.bottomTabs,
        currentIndex: controller.state.page,
        type: BottomNavigationBarType.fixed,
        onTap: controller.handleNavBarTap,
        showUnselectedLabels: true,
        showSelectedLabels: true,
      ));
    }
    
    return Scaffold(
      body: _buildPageView(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
}
