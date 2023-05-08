import 'package:app/router/app_route.dart';
import 'package:app/views/splash/splash_model.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  Rx<SplashModel> splashModelObj = SplashModel().obs;

  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(milliseconds: 1000), () {
      // Get.toNamed(AppRoutes.splashPhoneNumberScreen);
      Get.toNamed(AppRoute.indexPage);
      // Get.toNamed(AppRoute.listPage);
      // Get.toNamed(AppRoute.gridPage);
    });
  }

  @override
  void onClose() {
    super.onClose();
  }
}
