import 'package:app/views/grid_page/grid_page_controller.dart';
import 'package:get/get.dart';

class GridPageBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => GridPageController());
  }
}
