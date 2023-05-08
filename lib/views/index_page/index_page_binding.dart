import 'package:app/views/index_page/index_page_controller.dart';
import 'package:get/get.dart';

class IndexPageBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => IndexPageController());
  }
}
