import 'package:get/get.dart';

class ApplicationState{
  var _page = 0.obs;
  int get page {
    return _page.value;
  }
  set page(value){
    return _page.value = value;
  }
}