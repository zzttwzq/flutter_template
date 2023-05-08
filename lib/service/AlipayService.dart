import 'package:tobias/tobias.dart';

class AlipayService {
  static init() {}

  static isAlipayInstalled() async {
    return await isAliPayInstalled();
  }

  static pay(order) async {

    bool isInstall = await isAlipayInstalled();
    
    if (isInstall) {
     return aliPay(order);
    } else {
      print('未安装支付宝！');
    }

    return null;
  }
}
