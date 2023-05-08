import 'package:app/views/home_page/home_page_controller.dart';
import 'package:get/get.dart';

class HomePageBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => HomePageController());
  }
}
