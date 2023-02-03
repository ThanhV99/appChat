
import 'package:get/get.dart';
import 'controller.dart';

class ChatsBinding implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<ChatsController>(() => ChatsController());
  }
}