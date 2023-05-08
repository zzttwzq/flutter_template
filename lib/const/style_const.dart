import 'package:flutter/material.dart';

import '../utils/ui_util.dart';
import 'color_const.dart';
import 'font_const.dart';

class StyleConst with BaseUiMixin {

  static double sFontSize(double size) {
    // return ScreenUtil.getInstance().getSp(size);
    return size;
  }

  // static double sFontSize(double fontSize) {
  //   return ScreenUtil.getInstance().getSp(fontSize);
  // }

  static double tinyFont = sFontSize(6);
  static double smallFont = sFontSize(8);
  static double font_10 = sFontSize(10);
  static double normalFont = sFontSize(15);
  static double largeFont = sFontSize(20);
  static double hugeFont = sFontSize(26);

  static TextStyle toastTextStyle = TextStyle(
      color: ColorConst.toastTextColor, fontSize: largeFont);

  static TextStyle navigatorTitleStyle =
      TextStyle(color: ColorConst.mainTextColor, fontSize: largeFont);

  static BoxShadow shadowStyle = const BoxShadow(
    color: Color(0x105c5c5c), //底色,阴影颜色
    offset: Offset(0, 0), //阴影位置,从什么位置开始
    blurRadius: 6, // 阴影模糊层度
    spreadRadius: 2, //阴影模糊大小
    blurStyle: BlurStyle.normal,
  );

  static BoxShadow shadowStyle2(Color color) {
    color = Color.fromARGB(180, color.red, color.green, color.blue);

    return BoxShadow(
      color: color, //底色,阴影颜色
      offset: const Offset(0, 0), //阴影位置,从什么位置开始
      blurRadius: 6, // 阴影模糊层度
      spreadRadius: 1, //阴影模糊大小
      blurStyle: BlurStyle.normal,
    );
  }

  TextStyle panTitleStyle() {
    return TextStyle(
        color: ColorConst.mainTextColor, fontSize: largeFont);
  }

  /// 普通文本
  TextStyle smallTextStyle({Color? textColor, FontWeight? fontWeight}) {
    return TextStyle(
      color: textColor ?? ColorConst.mainTextColor,
      fontSize: sFontSize(smallFont),
      fontWeight: fontWeight ?? FontWeight.w400,
    );
  }

  /// 普通文本
  TextStyle normalTextStyle(
      {Color? textColor, FontWeight? fontWeight, double? fontSize}) {
    return TextStyle(
      color: textColor ?? ColorConst.mainTextColor,
      fontSize: fontSize ?? normalFont,
      fontWeight: fontWeight ?? FontWeight.w400,
    );
  }

  /// 大文本
  TextStyle largeTextStyle({Color? textColor, FontWeight? fontWeight}) {
    return TextStyle(
      color: textColor ?? ColorConst.mainTextColor,
      fontSize: sFontSize(largeFont),
      fontWeight: fontWeight ?? FontWeight.w400,
    );
  }

  /// 巨大文本
  TextStyle hugeTextStyle({Color? textColor, FontWeight? fontWeight}) {
    return TextStyle(
      color: textColor ?? ColorConst.mainTextColor,
      fontSize: sFontSize(hugeFont),
      fontWeight: fontWeight ?? FontWeight.w400,
    );
  }

  static panTitleText(
    String text,
  ) =>
      Text(text,
          textAlign: TextAlign.left, style: StyleConst().panTitleStyle());
}
