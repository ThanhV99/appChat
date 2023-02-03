import 'package:get/get.dart';

import 'controller.dart';

class LoginOrSignupBinding implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<LoginOrSignupController>(() => LoginOrSignupController());
  }
}