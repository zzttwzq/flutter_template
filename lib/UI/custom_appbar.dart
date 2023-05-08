import 'package:app/const/color_const.dart';
import 'package:flutter/material.dart';

class CustomAppBar {

  /// 常用的appbar
  static PreferredSizeWidget regularAppBar(
      String title) {
    return normalAppBar(title);
  }

  /// 可自定义的appbar
  static PreferredSizeWidget normalAppBar(
    String title, {
    Widget? leadingWidget,
    Widget? titleWidget,
    double elevation = 0.0,
    Color bgColor = Colors.white,
    IconThemeData? iconTheme,
    List<Widget>? actions,
  }) {
    return AppBar(
      leading: leadingWidget,
      title: titleWidget ?? Text(title, style: const TextStyle(color: ColorConst.mainColor, fontSize: 20),),
      centerTitle: true,
      elevation: elevation,
      backgroundColor: bgColor,
      iconTheme: iconTheme,
      actions: actions,
    );
  }

  /// 没有背景色的appbar
  static PreferredSizeWidget noBackAppBar() {
    return AppBar(
      leading: Container(),
      title: Container(),
      backgroundColor: Colors.transparent,
    );
  }

  /// 取消appbar
  static PreferredSizeWidget clearAppBar() {
    return const PreferredSize(
      preferredSize: Size.fromHeight(1 * 0.07),
      child: Offstage(
        offstage: true,
      ),
    );
  }
}
