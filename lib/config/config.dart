import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../const/color_const.dart';
import '../utils/http_util.dart';

/// 项目环境变量
enum EnvType {
  /// 开发环境
  dev,

  /// 测试环境
  test,

  /// 仿真环境
  preRelease,

  /// 正式环境
  release
}
/// 项目渠道
enum ChannelType {
  /// 不定义
  none,

  /// 苹果
  ios,

  /// 应用宝
  yingyongbao,

  /// 小米
  xiaomi,

  /// 华为
  huawei,

  /// Oppo
  oppo,

  /// Vivo
  vivo,

  /// meizu
  meizu,

  /// 豌豆荚
  wandoujia,

  /// 百度
  baidu,

  /// macos
  macos,

  /// 朗国
  langguo,

  /// windows
  windows,

  /// web
  web,
}

const bool kEnableMock = false;
const EnvType kCurrentType = EnvType.dev;
const ChannelType kCurrentChannelType = ChannelType.ios;

class Config {
  ///=============== app语言配置
  static const String appName = "TEST...";

  /// 默认本地语言，当指定的语言无法匹配时使用该语言
  static const defaultLocale = Locale("en", "US");

  ///=============== app网络请求配置
  /// 是否开启mock(打包会自动替换)
  static const bool enableMock = false;

  /// 连接超时时间
  static const int connectTimeout = 8000;

  /// 请求超时时间
  static const int requestTimeout = 8000;

  /// 请求日志输出
  static const bool logRequest = true;

  /// 默认contentType
  static const String defaultContentType = HttpContentType.formData;

  /// baseURL+
  static String getBaseUrl() {
    String url = "";
    if (Config.envType == EnvType.dev) {
      if (Config.enableMock) {
        url = 'https://xx.xxx.cc';
      } else {
        url = 'https://xx.xxx.cc';
      }
    } else if (Config.envType == EnvType.test) {
      url = 'https://xx.xxx.cc';
    } else if (Config.envType == EnvType.preRelease) {
      url = 'https://xx.xxx.cc';
    } else if (Config.envType == EnvType.release) {
      url = 'https://xx.xxx.cc';
    }

    debugPrint('baseURL=====>$url');
    return url;
  }

  static String getShareUrl() {
    return 'https://xx.xxx.cc';
  }

  ///=============== app打包信息配置
  static bool inProduction = const bool.fromEnvironment("dart.vm.product");

  /// 项目环境(打包会自动替换)
  static EnvType envType = kReleaseMode ? EnvType.release : kCurrentType;

  /// 发布渠道(打包会自动替换)
  static const ChannelType channelType = kCurrentChannelType;

  ///=============== appUI配置
  /// 吐司颜色配置
  static const toastDuration = Duration(seconds: 2);
  static const toastBackgroundColor = ColorConst.toastBackgroundColor;
  static const toastTextColor = ColorConst.toastTextColor;

  /// 使用基类以后页面背景色
  static const Color pageBackgroundColor = Colors.white;

  /// 设计尺寸计算
  static const double designWidth = 1920.0;
  static const double designHeight = 1080.0;
  static const double designDensity = 3.0;

  ///=============== app信息配置
  static const String methodChannelKey = "base_message_channel";

  /// 日志前缀，用于区分其他人的日志
  static const logPrefix = "W：";

  /// 是否上传日志到服务器
  static const bool uploadErrorLog = false;

  ///=============== 用户协议和隐私政策
  static String getUserProtocal({bool isIOS = true}) {
    return '';
  }

  static String getUserPolicy({bool isIOS = true}) {
    return '';
  }
}
