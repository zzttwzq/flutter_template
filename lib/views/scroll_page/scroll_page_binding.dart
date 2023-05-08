import 'package:app/views/scroll_page/scroll_page_controller.dart';
import 'package:get/get.dart';

class ScrollPageBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => ScrollPageController());
  }
}
