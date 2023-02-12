
import 'package:get/get.dart';
import '../contact/controller.dart';
import '../profile/controller.dart';
import 'controller.dart';

class ChatsBinding implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<ChatsController>(() => ChatsController());
    Get.lazyPut<ContactController>(() => ContactController());
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}