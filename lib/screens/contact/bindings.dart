
import 'package:get/get.dart';
import 'controller.dart';

class ContactBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<ContactController>(() => ContactController());
  }
}