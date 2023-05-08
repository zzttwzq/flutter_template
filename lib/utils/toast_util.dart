import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import '../config/config.dart';
import '../const/color_const.dart';
import '../const/style_const.dart';

class ToastUtil {
  ToastUtil._internal();

  ///全局初始化Toast配置, child为MaterialApp
  static initToast(Widget child) {
    return OKToast(
      textStyle: StyleConst.toastTextStyle,
      textAlign: TextAlign.start,
      backgroundColor: Config.toastBackgroundColor,
      radius: 8,
      dismissOtherOnShow: true,
      textPadding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      duration: Config.toastDuration,
      position:
          const ToastPosition(align: Alignment.bottomCenter, offset: -124),
      child: child,
    );
  }

  /// 黑色背景的吐司
  static void toast(String msg,
      {Duration duration = Config.toastDuration,
      ToastPosition position = ToastPosition.top,
      Color color = Config.toastTextColor}) {
    showToast(msg,
        dismissOtherToast: false,
        duration: duration,
        backgroundColor: ColorConst.toastBackgroundColor,
        position: const ToastPosition(align: Alignment.topCenter, offset: 10),
        textStyle: StyleConst()
            .normalTextStyle(textColor: Colors.white, fontSize: 17));
  }

  /// 警告
  static void waring(String msg, {Duration duration = Config.toastDuration}) {
    showToast(msg, duration: duration, backgroundColor: Colors.yellow);
  }

  /// 错误
  static void error(String msg, {Duration duration = Config.toastDuration}) {
    showToast(msg, duration: duration);
  }

  /// 成功
  static void success(String msg, {Duration duration = Config.toastDuration}) {
    showToast(msg, duration: duration, backgroundColor: Colors.lightGreen);
  }

  /// 显示
  /// loadingText 加载提示文本
  static Future show({String loadingText = ""}) async {
    if (loadingText.isEmpty) {
      loadingText = "toast-loading".tr;
    }
    EasyLoading.show(
        status: loadingText,
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.none);
  }

  /// 隐藏
  static Future dismiss() async {
    if (EasyLoading.isShow) {
      EasyLoading.dismiss();
    }
  }

  static showLoading({
    String? status,
    Widget? indicator,
    EasyLoadingMaskType? maskType,
    bool? dismissOnTap,
  }) {
    EasyLoading.show(
      status: status,
      indicator: indicator,
      maskType: maskType,
      dismissOnTap: dismissOnTap,
    );
  }
}
