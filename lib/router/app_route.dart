import 'package:app/views/grid_page/grid_page.dart';
import 'package:app/views/grid_page/grid_page_binding.dart';
import 'package:app/views/home_page/home_page_binding.dart';
import 'package:app/views/index_page/index_page.dart';
import 'package:app/views/index_page/index_page_binding.dart';
import 'package:app/views/list_page/list_page.dart';
import 'package:app/views/list_page/list_page_binding.dart';
import 'package:app/views/login_page/login_page.dart';
import 'package:app/views/login_page/login_page_binding.dart';
import 'package:app/views/splash/splash_screen.dart';
import 'package:get/get.dart';

import '../views/home_page/home_page.dart';
import '../views/mine_page/mine_page.dart';
import '../views/mine_page/mine_page_binding.dart';
import '../views/splash/splash_binding.dart';

class AppRoute {
  static String initialRoute = listPage;

  static String splashPage = "/splashPage";
  static String loginPage = "/login";
  static String indexPage = "/index";
  static String homePage = "/home";
  static String minePage = "/mine";
  static String listPage = "/list";
  static String gridPage = "/grid";
  static String providerTestPage = "/providerTestPage";

  static List<GetPage> pages = [
    GetPage(
        name: splashPage,
        page: () => SplashScreen(),
        bindings: [SplashBinding()]),
    GetPage(
        name: loginPage,
        page: () => LoginPage(),
        bindings: [LoginPageBinding()]),
    GetPage(
        name: indexPage,
        page: () => IndexPage(),
        bindings: [IndexPageBinding()],
        transition: Transition.rightToLeft),
    GetPage(
        name: minePage,
        page: () => const HomePage(),
        bindings: [HomePageBinding()]),
    GetPage(
        name: minePage,
        page: () => const MinePage(),
        bindings: [MinePageBinding()]),
    GetPage(
        name: listPage, page: () => ListPage(), bindings: [ListPageBinding()]),
    GetPage(
        name: gridPage, page: () => GridPage(), bindings: [GridPageBinding()]),
  ];

  /// 跳转页面
  static gotoPage(String page, {Map arguments = const {}}) {
    Get.toNamed(page, arguments: arguments);
  }

  /// 返回上一页
  static back() {
    Get.back();
  }

  ///
  static offNamed(String page) {
    Get.offNamed(page);
  }
}
