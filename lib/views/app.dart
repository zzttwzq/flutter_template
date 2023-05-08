import 'package:app/config/config.dart';
import 'package:app/views/grid_page/grid_page_binding.dart';
import 'package:app/views/grid_page/grid_page_controller.dart';
import 'package:app/views/list_page/list_page_binding.dart';
import 'package:app/views/scroll_page/scroll_page_binding.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../localization/app_localization.dart';
import 'package:app/theme/theme_config.dart';
import 'package:app/router/app_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/toast_util.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {

    ListPageBinding().dependencies();
    GridPageBinding().dependencies();
    ScrollPageBinding().dependencies();
  }
}

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: AppLocalization(),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('en', 'US'),
      title: Config.appName,
      initialBinding: InitialBindings(),
      initialRoute: AppRoute.initialRoute,
      getPages: AppRoute.pages,
      theme: ThemeConfig.lightTheme,
      builder:
          EasyLoading.init(builder: (BuildContext context, Widget? widget) {
        return Material(
          child: ToastUtil.initToast(widget!),
        );
      }),
    );
  }
}
