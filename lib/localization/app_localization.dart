import 'dart:ui';

import 'package:flutterbase/utils/log_util.dart';
import 'package:get/get.dart';

import '../config/config.dart';
import 'lang/en_US.dart';
import 'lang/ja_JP.dart';
import 'lang/zh_CN.dart';
import 'lang/zh_TW.dart';

enum LanguageType {
  enUS,
  zhCN,
  jaJP,
  zhTW,
}

class AppLocalization extends Translations {
  Map<String, Map<String, String>> get _supportLanguages => {
        'en_US': en_US,
        'zh_CN': zh_CN,
        'zh_TW': zh_TW,
        'ja_JP': ja_JP,
      };

  ///
  static List<Locale> languages = [
    const Locale('en', 'US'),
    const Locale('zh', 'CN'),
    const Locale('zh', 'TW'),
    const Locale('ja', 'JP'),
  ];

  static List langList = [
    {'name': 'zh-CN', 'langCode': 'zh', 'countryCode': 'CN'},
    {'name': 'en-US', 'langCode': 'en', 'countryCode': 'US'},
    {'name': 'ja-JP', 'langCode': 'ja', 'countryCode': 'JP'},
    {'name': 'zh-TW', 'langCode': 'zh', 'countryCode': 'TW'},
  ];

  @override
  Map<String, Map<String, String>> get keys {
    return _supportLanguages;
  }

  /// 获取默认语言
  static Locale getDefaultLanguage() {
    LogUtil.debug("===>默认语言: ${Config.defaultLocale}");
    return Config.defaultLocale;
  }

  /// 获取当前的语言
  static getCurrentLocale() {
    return Get.locale;
  }

  /// 获取当前系统语言
  static Locale getCurrentSystemLanguage() {
    Locale locales = PlatformDispatcher.instance.locale;
    LogUtil.debug("===>当前系统语言: ${locales.languageCode}");
    return Locale(locales.languageCode);
  }

  /// 切换语言
  static switchLanguage(Locale? locale) {
    Get.updateLocale(locale ?? Config.defaultLocale);
  }

  /// 切换语言
  static switchLanguageByType(LanguageType languageType) {
    switch (languageType) {
      case LanguageType.enUS:
        switchLanguage(const Locale('en', 'US'));
        break;
      case LanguageType.zhCN:
        switchLanguage(const Locale('zh', 'CN'));
        break;
      case LanguageType.jaJP:
        switchLanguage(const Locale('ja', 'JP'));
        break;
      case LanguageType.zhTW:
        switchLanguage(const Locale('zh', 'TW'));
        break;
    }
  }

  /// 根据语言字符串
  static switchLanguageByString(String languageString) {
    languageString = languageString.toLowerCase();

    if (languageString.contains('en') || languageString.contains('us')) {
      switchLanguageByType(LanguageType.enUS);
    } else if (languageString.contains('cn') || languageString.contains('zh')) {
      switchLanguageByType(LanguageType.zhCN);
    } else if (languageString.contains('ja') || languageString.contains('jp')) {
      switchLanguageByType(LanguageType.jaJP);
    } else if (languageString.contains('tw') ||
        languageString.contains('zh_tw')) {
      switchLanguageByType(LanguageType.zhTW);
    }
  }

  /// 根据类型获取语言
  static getLanguage(LanguageType languageType) {
    switch (languageType) {
      case LanguageType.enUS:
        return const Locale('en', 'US');
      case LanguageType.zhCN:
        return const Locale('zh', 'CN');
      case LanguageType.jaJP:
        return const Locale('ja', 'JP');
      case LanguageType.zhTW:
        return const Locale('zh', 'TW');
    }
  }
}
