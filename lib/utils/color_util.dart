import 'dart:math';
import 'package:flutter/material.dart';

import '../const/color_const.dart';

class ColorUtil {
  /// 处理颜色
  static Color handleColor(String? color,
      {dynamic alpha = 100, List<Color> colorList = ColorConst.colorList}) {
    if (color == null || color == "none" || color == "null") {
      return Colors.transparent;
    }

    dynamic temp = alpha;
    if (temp == null) {
      temp = 100;
    } else {
      temp = alpha.toDouble();
    }

    Color c = Colors.transparent;

    if (color.contains("#")) {
      c = ColorUtil.fromHex(color);
    } else if (color.contains("placeIndex")) {
      String i = color.split(':')[1].split('}')[0];
      int index = int.parse(i);

      if (index < 0) {
        index = 0;
        c = ColorConst.whiteBoradBgColor;
      }
      else if (index >= colorList.length) {
        c = Colors.red;
      }
      else {
        c = colorList[index];
      }

    } else if (color == '0') {

    } else if (color == 'Color(0xff000000)') {
      c = ColorConst.colorList[0];
    } else {
      c = ColorUtil.fromRGBA(color);
    }

    c = Color.fromARGB(((temp! / 100) * 255).toInt(), c.red, c.green, c.blue);

    return c;
  }

  /// hex字符串生成color
  static Color fromHex(String code) {
    //先判断是否符合#RRGGBB的要求如果不符合给一个默认颜色
    if (code == null || code == "" || code.length != 7) {
      return const Color(0xFFFF0000); //定了一个默认的主题色常量
    }
    // #rrggbb 获取到RRGGBB转成16进制 然后在加上FF的透明度
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  /// rgba字符串生成color
  static Color fromRGBA(String str) {
    List rgbaList = str.substring(5, str.length - 1).split(",");
    return Color.fromRGBO(int.parse(rgbaList[0]), int.parse(rgbaList[1]),
        int.parse(rgbaList[2]), double.parse(rgbaList[3]));
  }

  /// 颜色生成hex字符串
  static String toHex(Color color) {
    if (color is Color) {
      // 0xFFFFFFFF
      //将十进制转换成为16进制 返回字符串但是没有0x开头
      String temp = color.value.toRadixString(16);
      color = "#${temp.substring(0, 8)}" as Color;
    }

    String s = color.toString();
    s = s.toUpperCase();
    return s;
  }

  /// 颜色生成rgba字符串
  static String toRGBA(Color color) {
    return 'rgba(${color.red},${color.green},${color.blue},${color.alpha})';
  }

  /// 设置颜色alpha
  static Color setColorAlpha(Color color, double alph) {
    return color.withAlpha((alph / 100 * 255).toInt());
  }

  /// 获取随机颜色
  static Color getRandomColor() {
    return Color.fromARGB(
      255,
      Random.secure().nextInt(200),
      Random.secure().nextInt(200),
      Random.secure().nextInt(200),
    );
  }
}
