import 'package:app/views/test_page/test_page_controller.dart';
import 'package:get/get.dart';

class TestPageBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => TestPageController());
  }
}
