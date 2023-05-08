import 'package:app/localization/lang/en_US.dart';
import 'package:app/localization/lang/zh_CN.dart';
import 'package:get/get.dart';

class AppLocalization extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {'en_US': en_US, 'zh_CN': zh_CN};
}
