import 'package:app/utils/toast_util.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flustars/flustars.dart';

class ClipboardUtil {
  //复制内容
  static setData(String data) {
    if (data != null && data != '') {
      Clipboard.setData(ClipboardData(text: data));
    }
  }

  //复制内容
  static setDataToast(String data) {
    if (data != null && data != '') {
      Clipboard.setData(ClipboardData(text: data));
      ToastUtil.toast("toast-copy-succeed".tr);
    }
  }

  //复制内容
  static setDataToastMsg(String data, {String toastMsg = '复制成功'}) {
    if (data != null && data != '') {
      Clipboard.setData(ClipboardData(text: data));
      ToastUtil.toast(toastMsg);
    }
  }

  //获取内容
  static Future<String> getClipboardData() async {
    ClipboardData? data = await Clipboard.getData(Clipboard.kTextPlain);
    if (ObjectUtil.isEmpty(data?.text)) {
      return '';
    } else {
      return data!.text!;
    }
  }
}
