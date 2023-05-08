import 'package:app/const/style_const.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';

abstract class BaseUiMixin {
  /// screen width
  /// 屏幕 宽
  double get screenWidth => ScreenUtil.getInstance().screenWidth;

  /// screen height
  /// 屏幕 高
  double get screenHeight => ScreenUtil.getInstance().screenHeight;

  ///appBarHeight
  double get appBarHeight => ScreenUtil.getInstance().appBarHeight;

  ///bottomBarHeight
  double get bottomBarHeight => ScreenUtil.getInstance().bottomBarHeight;

  ///除去标题栏的真实page高度
  double get pageNoTitleHeight =>
      screenHeight -
      44 -
      ScreenUtil.getInstance().statusBarHeight -
      ScreenUtil.getInstance().bottomBarHeight;

  double get statusBarHeight => ScreenUtil.getInstance().statusBarHeight;



  // double sFontSize(double size) {
  //   return ScreenUtil.getInstance().getSp(size);
  // }

  /// 可空
  double? sFontSizeNullable(double? size) {
    if (size == null) return null;
    return StyleConst.sFontSize(size);
  }

  double sHeight(double size) {
    if (size == double.infinity) {
      return size;
    }
    return ScreenUtil.getInstance().getHeight(size);
  }

  /// 可空
  double? sHeightNullable(double? size) {
    if (size == null) return null;
    if (size == double.infinity) {
      return size;
    }
    return sHeight(size);
  }

  double sWidth(double size) {
    if (size == double.infinity) {
      return size;
    }
    return ScreenUtil.getInstance().getWidth(size);
  }

  /// 可空
  double? sWidthNullable(double? size) {
    if (size == null) return null;
    if (size == double.infinity) {
      return size;
    }
    return sWidth(size);
  }

  double sRadius(double size) {
    return ScreenUtil.getInstance().getWidth(size);
  }

  /// 可空
  double? sRadiusNullable(double? size) {
    if (size == null) return null;
    return sRadius(size);
  }

  /// 设置统一圆角的BorderRadius
  BorderRadius sBorderRadius(double radius) {
    return BorderRadius.all(Radius.circular(sRadius(radius)));
  }

  BorderRadius? sBorderRadiusNullable(double? radius) {
    if (radius == null) return null;
    return sBorderRadius(radius);
  }

  /// 四个圆角分别设置的BorderRadius
  BorderRadius sBorderRadiusOnly(
      double topLeft, double topRight, double bottomLeft, double bottomRight) {
    return BorderRadius.only(
        topLeft: Radius.circular(sRadius(topLeft)),
        topRight: Radius.circular(sRadius(topRight)),
        bottomLeft: Radius.circular(sRadius(bottomLeft)),
        bottomRight: Radius.circular(sRadius(bottomRight)));
  }

  /// 只设置顶部圆角设置的BorderRadius
  BorderRadius sBorderRadiusTop(double topLeft, double topRight) {
    return BorderRadius.only(
        topLeft: Radius.circular(sRadius(topLeft)),
        topRight: Radius.circular(sRadius(topRight)));
  }

  /// 只设置底部圆角设置的BorderRadius
  BorderRadius sBorderRadiusBottom(double bottomLeft, double bottomRight) {
    return BorderRadius.only(
        bottomLeft: Radius.circular(sRadius(bottomLeft)),
        bottomRight: Radius.circular(sRadius(bottomRight)));
  }

  EdgeInsets sInsetsLTRB(double left, double top, double right, double bottom) {
    return EdgeInsets.fromLTRB(
      sWidth(left),
      sHeight(top),
      sWidth(right),
      sHeight(bottom),
    );
  }

  EdgeInsets sInsetsOnly(
      {double left = 0, double top = 0, double right = 0, double bottom = 0}) {
    return EdgeInsets.fromLTRB(
      sWidth(left),
      sHeight(top),
      sWidth(right),
      sHeight(bottom),
    );
  }

  EdgeInsets sInsetsAll(double value) {
    return EdgeInsets.fromLTRB(
      sWidth(value),
      sWidth(value),
      sWidth(value),
      sWidth(value),
    );
  }

  EdgeInsets sInsetsHV(double h, double v) {
    return EdgeInsets.fromLTRB(
      sWidth(h),
      sHeight(v),
      sWidth(h),
      sHeight(v),
    );
  }

  EdgeInsets sMargin(dynamic margin) {
    switch (margin.length) {
      case 2:
        return EdgeInsets.symmetric(
            vertical: sHeight(margin[0]), horizontal: sWidth(margin[1]));
      case 4:
        return sInsetsLTRB(margin[0], margin[1], margin[2], margin[3]);
      default:
        return sInsetsLTRB(margin[0], margin[0], margin[0], margin[0]);
    }
  }

  EdgeInsets sPadding(dynamic padding) {
    switch (padding.length) {
      case 2:
        return EdgeInsets.symmetric(
            vertical: sHeight(padding[0]), horizontal: sWidth(padding[1]));
      case 4:
        return sInsetsLTRB(padding[0], padding[1], padding[2], padding[3]);
      default:
        return sInsetsLTRB(padding[0], padding[0], padding[0], padding[0]);
    }
  }

  Widget paddingH30(Widget child) {
    return Padding(
      padding: sInsetsHV(30, 0),
      child: child,
    );
  }

  Widget paddingH32(Widget child) {
    return Padding(
      padding: sInsetsHV(32, 0),
      child: child,
    );
  }

  Widget paddingH40(Widget child) {
    return Padding(
      padding: sInsetsHV(40, 0),
      child: child,
    );
  }

  Widget paddingH24(Widget child) {
    return Padding(
      padding: sInsetsHV(24, 0),
      child: child,
    );
  }

  Widget paddingH20(Widget child) {
    return Padding(
      padding: sInsetsHV(20, 0),
      child: child,
    );
  }

  Widget paddingV20(Widget child) {
    return Padding(
      padding: sInsetsHV(0, 20),
      child: child,
    );
  }

  Widget paddingV32(Widget child) {
    return Padding(
      padding: sInsetsHV(0, 32),
      child: child,
    );
  }

  Widget paddingVH24(Widget child) {
    return Padding(
      padding: sInsetsHV(24, 24),
      child: child,
    );
  }

  Widget paddingV20H30(Widget child) {
    return Padding(
      padding: sInsetsHV(30, 20),
      child: child,
    );
  }

  Widget paddingV32H32(Widget child) {
    return Padding(
      padding: sInsetsHV(32, 22),
      child: child,
    );
  }

  Widget sizeBoxW24() {
    return SizedBox(width: sWidth(24));
  }

  Widget sizeBoxH24() {
    return SizedBox(height: sHeight(24));
  }

  Widget sizeBoxW12() {
    return SizedBox(width: sWidth(24));
  }

  Widget sizeBoxH12() {
    return const SizedBox(height: 12);
  }

  Widget sizeBoxH20() {
    return SizedBox(height: sHeight(20));
  }

  Widget sizeBoxW32() {
    return SizedBox(width: sWidth(32));
  }

  Widget sizeBoxH32() {
    return SizedBox(height: sHeight(32));
  }

  Widget sizeBox({double width = 0, double height = 0}) {
    return SizedBox(width: sWidth(width), height: sHeight(height));
  }

  double get toolBarHeight => sHeight(88);

  double dpToPX(double dp) {
    return sWidth(dp) * ScreenUtil.getInstance().screenDensity;
  }
}
