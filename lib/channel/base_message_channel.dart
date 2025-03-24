import 'dart:async';
import 'package:app/config/config.dart';
import 'package:flutter/services.dart';
import 'package:flutterbase/flutterbase.dart';

class PaintParamChannel {
  /// 定义方法渠道, deviceinfo必须和原生定义的一模一样.
  static const MethodChannel _channel = MethodChannel(Config.methodChannelKey);

  /// 获取安卓版本
  static const String getAndroidVersion = 'flutter_getAndroidVersion';

  /// 获取安卓版本
  static Future<String> getAndroidVerison() async {
    var d = await _channel.invokeMethod(getAndroidVersion);
    LogUtil.debug(">>>geAndroidVerison: ${d}");
    return d;
  }

  /// 监听数据
  static listenMethod(Function(String method, Map data) callBack) {
    _channel.setMethodCallHandler(
          (call) {

        LogUtil.debug(">>> listenMethod ${call}");

        //
        if (call.method == 'xxxx') {
          callBack(call.method, call.arguments);
          return Future.value('');
        }

        return Future.value('');
      },
    );
  }
}
