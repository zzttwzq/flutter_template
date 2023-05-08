import 'package:app/views/list_page/list_page_controller.dart';
import 'package:get/get.dart';

class ListPageBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => ListPageController());
  }
}
