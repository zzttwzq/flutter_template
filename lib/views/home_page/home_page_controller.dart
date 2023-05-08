import 'package:app/views/home_page/home_page_model.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {
  Rx<HomePageModel> homePageModel = HomePageModel().obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
