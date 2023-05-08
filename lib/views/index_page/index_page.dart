import 'package:app/UI/custom_appbar.dart';
import 'package:app/utils/ui_util.dart';
import 'package:app/views/grid_page/grid_page.dart';
import 'package:app/views/home_page/home_page.dart';
import 'package:app/views/index_page/index_page_controller.dart';
import 'package:app/views/list_page/list_page.dart';
import 'package:app/views/mine_page/mine_page.dart';
import 'package:app/views/scroll_page/scroll_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// class IndexPage extends GetView with BaseUiMixin {
class IndexPage extends StatefulWidget with BaseUiMixin {
  IndexPage({super.key});

  @override
  State<StatefulWidget> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> with BaseUiMixin {
  final IndexPageController indexPageController =
      Get.find<IndexPageController>();
  PageController pageController = PageController(initialPage: 1);
  int currentPage = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar.clearAppBar(),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),

          ///中间悬浮按钮嵌入BottomAppBar
          notchMargin: 10,

          ///缺口边距
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  icon: Icon(Icons.home, color: currentPage == 1 ? Colors.blue : Colors.black),
                  onPressed: () {
                    // indexPageController.changeTab(0);
                    // var list = [];
                    // list[1];
                    pageController.jumpToPage(0);

                    setState(() {
                      currentPage = 1;
                    });


                  }),
              IconButton(
                  icon: Icon(Icons.person, color: currentPage == 2 ? Colors.blue : Colors.black),
                  onPressed: () {
                    // indexPageController.changeTab(1);
                    pageController.jumpToPage(1);

                    setState(() {
                      currentPage = 2;
                    });
                  }),
              // IconButton(
              //     icon: const Icon(Icons.person),
              //     onPressed: () {
              //       // indexPageController.changeTab(1);
              //       pageController.jumpToPage(2);
              //     }),
              // IconButton(
              //     icon: const Icon(Icons.person),
              //     onPressed: () {
              //       // indexPageController.changeTab(1);
              //       pageController.jumpToPage(3);
              //     }),
              // IconButton(
              //     icon: const Icon(Icons.person),
              //     onPressed: () {
              //       // indexPageController.changeTab(1);
              //       pageController.jumpToPage(4);
              //     }),])
            ],
          ),
        ),

        /// 悬浮按钮
        floatingActionButton: FloatingActionButton(
          foregroundColor: Colors.white,
          elevation: 10.0,

          ///阴影
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: Container(
            child: PageView(
          controller: pageController,
          children: [
            HomePage(),
            MinePage(),
            ListPage(),
            GridPage(),
            ScrollPage()
          ],
        )));
  }
}
