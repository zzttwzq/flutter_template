import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutterbase/flutterbase.dart';

import '../const/color_const.dart';

/// 如果环境时release 就强制改成EnvType.release，其他在后面改就可以
const EnvType kCurrentType = EnvType.dev;
bool kEnableMock = kReleaseMode
    ? false
    : kCurrentType == EnvType.release
        ? false
        : true;
const RequestLog kCurrentLevel = RequestLog.full;
const ChannelType kCurrentChannelType = ChannelType.langguo;

class Config {
  ///=============== app打包信息配置
  /// 是否开启mock(打包会自动替换)
  static bool enableMock = false;

  static String logPrefix = "www";

  /// 项目请求日志类型(打包会自动替换)
  // static const RequestLog requestLogLevel = RequestLogLevel.fullLog;

  /// 项目环境(打包会自动替换)
  static EnvType envType = EnvType.test;

  /// 发布渠道(打包会自动替换)
  static const ChannelType channelType = kCurrentChannelType;

  /// 是否上传日志到服务器
  static const bool uploadErrorLog = false;

  ///=============== app语言配置
  /// 默认本地语言，当指定的语言无法匹配时使用该语言
  static const defaultLocale = Locale("en", "US");

  static const String appName = "omapp";
  static const String methodChannelKey = "com.linker.omapp";

  ///=============== app网络请求配置
  /// 连接超时时间
  static const int connectTimeout = 4000;

  /// 请求超时时间
  static const int requestTimeout = 4000;

  /// 请求日志输出
  static const bool logRequest = true;

  /// 默认contentType
  static const String defaultContentType = Headers.jsonContentType;

  /// baseURL+
  static String get baseHost {
    String url = "";
    if (Config.envType == EnvType.dev) {
      url = "https://hd-node1.linker.cc/omappagent";
    } else if (Config.envType == EnvType.test) {
      url = "https://hd-node1.linker.cc/omappagent";
    } else if (Config.envType == EnvType.preRelease) {
      url = "http://prod-cn.your-api-server.com";
    } else if (Config.envType == EnvType.release) {
      url = "http://prod-cn.your-api-server.com";
    }
    return url;
  }

  ///=============== appUI配置
  /// 吐司颜色配置
  static const toastDuration = Duration(seconds: 2);
  static const toastBackgroundColor = ColorConst.toastBackgroundColor;
  static const toastTextColor = ColorConst.toastTextColor;

  /// 使用基类以后页面背景色
  static const Color pageBackgroundColor = Colors.white;

  /// 设计尺寸计算
  static const designSize = Size(375, 812);
  static const double designDensity = 3.0;

  ///=============== 用户协议
  /// 1 苹果 2 安卓
  static String getUserProtocal({bool isIOS = true}) {
    switch (Config.envType) {
      case EnvType.dev:
        return "http://www.nearhub.cc/${isIOS ? 0 : 1}/privacy.html";
      case EnvType.test:
        return "http://www.nearhub.cc/${isIOS ? 0 : 1}/privacy.html";
      case EnvType.preRelease:
        return "http://www.nearhub.cc/${isIOS ? 0 : 1}/privacy.html";
      case EnvType.release:
        return "http://www.nearhub.cc/${isIOS ? 0 : 1}/privacy.html";
      default:
        return "http://www.nearhub.cc/${isIOS ? 0 : 1}/privacy.html";
    }
  }

  /// 用户隐私
  /// 1 苹果 2 安卓
  static String getUserPolicy({bool isIOS = true}) {
    switch (Config.envType) {
      case EnvType.dev:
        return "http://www.nearhub.cc/${isIOS ? 0 : 1}/privacy.html";
      case EnvType.test:
        return "http://www.nearhub.cc/${isIOS ? 0 : 1}/privacy.html";
      case EnvType.preRelease:
        return "http://www.nearhub.cc/${isIOS ? 0 : 1}/privacy.html";
      case EnvType.release:
        return "http://www.nearhub.cc/${isIOS ? 0 : 1}/privacy.html";
      default:
        return "http://www.nearhub.cc/${isIOS ? 0 : 1}/privacy.html";
    }
  }
}
