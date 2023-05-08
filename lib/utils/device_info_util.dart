import 'dart:io';
import 'dart:math';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:nanoid/async.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../config/config.dart';

class DeviceInfoUtil {
  /// 获取环境名称
  static String getEnvName() {
    var txt = "";
    switch (Config.envType) {
      case EnvType.dev:
        txt = "开发/测试环境";
        break;
      case EnvType.test:
        txt = "开发/测试环境";
        break;
      case EnvType.preRelease:
        txt = "仿真环境环境";
        break;
      case EnvType.release:
        txt = "正式环境";
        break;
    }

    return txt;
  }

  /// 获取渠道名称
  static String getChannelName() {
    var channel = "";
    switch (Config.channelType) {
      case ChannelType.none:
        channel = "unknown";
        break;
      case ChannelType.ios:
        channel = "apple-store";
        break;
      case ChannelType.yingyongbao:
        channel = "yyb";
        break;
      case ChannelType.xiaomi:
        channel = "xiaomi";
        break;
      case ChannelType.huawei:
        channel = "huawei";
        break;
      case ChannelType.oppo:
        channel = "oppo";
        break;
      case ChannelType.vivo:
        channel = "vivo";
        break;
      case ChannelType.meizu:
        channel = "meizu";
        break;
      case ChannelType.wandoujia:
        channel = "wandoujia";
        break;
      case ChannelType.baidu:
        channel = "baidu";
        break;
    }

    return channel;
  }

  /// 获取当前的版本号，从pubspec文件中获取
  static Future<String> getAppName() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appName = packageInfo.appName; //版本号
    return appName;
  }

  /// 获取当前的版本号，从pubspec文件中获取
  static Future<String> getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version; //版本号
    return version;
  }

  /// 获取当前的版本构建号，从pubspec文件中获取
  static Future<String> getVersionNumber() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String buildNumber = packageInfo.buildNumber; //版本构建号
    return buildNumber;
  }

  /// 获取设备详细名称
  static Future<String> getDeviceName() async {
    // if (Platform.isAndroid) {
    //   AndroidDeviceInfo data = await getAndroidDeviceInfo();
    //   return data.model;
    // }
    // if (Platform.isIOS) {
    //   IosDeviceInfo data = await getIOSDeviceInfo();
    //   return data.model;
    // }
    return '';
  }

  /// 获取app名称
  static Future<String> get appName async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.appName;
  }

  /// 获取app包名
  static Future<String> get packageName async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.packageName;
  }

  /// 获取app版本号
  static Future<String> get version async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  /// 获取app构建版本号
  static Future<String> get buildNumber async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.buildNumber;
  }

  /// 获取系统信息
  static getOs() async {
    return "";
    // String platformVersion = await DeviceInfoUtil.platformVersion ?? "";
    // os = (defaultTargetPlatform == TargetPlatform.android ? 'Android' : 'ios') +
    //     '-${platformVersion}';
    // return os;
  }

  static Future<Map<String, dynamic>> initPlatformState() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    Map<String, dynamic> deviceData = <String, dynamic>{};

    try {
      if (kIsWeb) {
        deviceData = _readWebBrowserInfo(await deviceInfoPlugin.webBrowserInfo);
      } else {
        if (Platform.isAndroid) {
          deviceData =
              _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
        } else if (Platform.isIOS) {
          deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
        } else if (Platform.isLinux) {
          deviceData = _readLinuxDeviceInfo(await deviceInfoPlugin.linuxInfo);
        } else if (Platform.isMacOS) {
          deviceData = _readMacOsDeviceInfo(await deviceInfoPlugin.macOsInfo);
        } else if (Platform.isWindows) {
          deviceData =
              _readWindowsDeviceInfo(await deviceInfoPlugin.windowsInfo);
        }
      }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }

    return deviceData;
  }

  static String getRandomUid(String string) {
    var d = DateTime.now().millisecondsSinceEpoch;
    var r = Random().nextInt(9999);
    var s = "${string}_${nanoid()}_${d}_${r}";
    s = EncryptUtil.encodeMd5(s);

    return s;
  }

  static Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      // 'androidId': build.androidId,
      'systemFeatures': build.systemFeatures,
      'pUid': getRandomUid(build.id ?? ""),
    };
  }

  static Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    var pUid = "${data.name}_${data.systemName}_${data.model}";

    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
      'pUid': getRandomUid(pUid),
    };
  }

  static Map<String, dynamic> _readLinuxDeviceInfo(LinuxDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'version': data.version,
      'id': data.id,
      'idLike': data.idLike,
      'versionCodename': data.versionCodename,
      'versionId': data.versionId,
      'prettyName': data.prettyName,
      'buildId': data.buildId,
      'variant': data.variant,
      'variantId': data.variantId,
      'machineId': data.machineId,
      'pUid': getRandomUid(data.id),
    };
  }

  static Map<String, dynamic> _readWebBrowserInfo(WebBrowserInfo data) {
    var pUid = "${data.platform}_${data.userAgent}";

    return <String, dynamic>{
      'browserName': describeEnum(data.browserName),
      'appCodeName': data.appCodeName,
      'appName': data.appName,
      'appVersion': data.appVersion,
      'deviceMemory': data.deviceMemory,
      'language': data.language,
      'languages': data.languages,
      'platform': data.platform,
      'product': data.product,
      'productSub': data.productSub,
      'userAgent': data.userAgent,
      'vendor': data.vendor,
      'vendorSub': data.vendorSub,
      'hardwareConcurrency': data.hardwareConcurrency,
      'maxTouchPoints': data.maxTouchPoints,
      'pUid': getRandomUid(pUid),
    };
  }

  static Map<String, dynamic> _readMacOsDeviceInfo(MacOsDeviceInfo data) {
    return <String, dynamic>{
      'computerName': data.computerName,
      'hostName': data.hostName,
      'arch': data.arch,
      'model': data.model,
      'kernelVersion': data.kernelVersion,
      'osRelease': data.osRelease,
      'activeCPUs': data.activeCPUs,
      'memorySize': data.memorySize,
      'cpuFrequency': data.cpuFrequency,
      'systemGUID': data.systemGUID,
      'pUid': getRandomUid(data.systemGUID ?? ""),
    };
  }

  static Map<String, dynamic> _readWindowsDeviceInfo(WindowsDeviceInfo data) {
    return <String, dynamic>{
      'numberOfCores': data.numberOfCores,
      'computerName': data.computerName,
      'systemMemoryInMegabytes': data.systemMemoryInMegabytes,
      'pUid': getRandomUid(data.computerName),
    };
  }
}
