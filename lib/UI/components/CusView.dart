import 'dart:convert';

import 'package:flutter/material.dart';

class CusView extends State with WidgetsBindingObserver {
  var title = "";
  var showNoDataView = true;

  var bgcolor;
  var elevation = 0.0;
  var navBarBackground = Colors.white;
  var navBarTextTheme = const TextTheme();
  var navBarIconTheme = const IconThemeData(color: Colors.black);

  @override
  void initState() {
    super.initState();

    getData();

    setState(() {
      customValue();
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('>>>>>>>>:::didChangeAppLifecycleState');
    print(state);
  }

  @override
  Widget build(BuildContext context) {
    // PushService.addGeTuiListener(context);

    return Scaffold(
        appBar: custAppBar(),
        body: SafeArea(
            child: GestureDetector(
                onTap: () {
                  //点击空白处隐藏键盘
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: getBackgroundColor(),
                  child: custView(context),
                ))));
  }

  // ==========  appbar
  // 自定义appbar
  PreferredSizeWidget custAppBar() {
    return lightStyleAppBar();
  }

  Widget getNavBarLeading() {
    return TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Image.asset(
        'assets/images/arrow_back.png',
        height: 100,
      ),
    );
  }

  List<Widget> getNavRightBottom() {
    return [];
  }

  PreferredSizeWidget lightStyleAppBar() {
    if (title.length == 0) {
      return AppBar(
        leading: null,
        title: getNavBarLeading(),
        centerTitle: false,
        elevation: elevation,
        backgroundColor: navBarBackground,
        iconTheme: navBarIconTheme,
        // 右侧按钮图标
        actions: getNavRightBottom(),
      );
    }

    return AppBar(
      leading: getNavBarLeading(),
      title: Text(title),
      elevation: elevation,
      backgroundColor: navBarBackground,
      iconTheme: navBarIconTheme,
      // 右侧按钮图标
      actions: getNavRightBottom(),
    );
  }

  Widget darkStyleAppBar() {
    if (title.length == 0) {
      return AppBar(
        title: getNavBarLeading(),
        centerTitle: false,
        elevation: elevation,
        backgroundColor: navBarBackground,
        iconTheme: navBarIconTheme,
        // 右侧按钮图标
        actions: getNavRightBottom(),
      );
    }

    return AppBar(
      leading: getNavBarLeading(),
      title: Text(title),
      elevation: elevation,
      backgroundColor: navBarBackground,
      iconTheme: navBarIconTheme,
      // 右侧按钮图标
      actions: getNavRightBottom(),
    );
  }

  Widget noBackAppBar() {
    return AppBar(
      leading: null,
      title: Text(title),
      elevation: elevation,
      backgroundColor: navBarBackground,
      iconTheme: navBarIconTheme,
    );
  }

  Widget clearAppBar() {
    return PreferredSize(
      child: Offstage(
        offstage: true,
      ),
      preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.07),
    );
  }

  // ==========
  customValue() async {
    // print("CustView custValue...");
  }

  Widget custView(context) {
    // print("CustView custView...");
    return Container();
  }

  // ========== 没有数据界面
  Widget custNoDataView() {
    // print("CustView custNoDataView...");
    return Container();
  }

  getBackgroundColor() {
    return Colors.white;
  }

  // ========== 获取数据
  getData() async {
    // print("CustView getData...");
  }
}
