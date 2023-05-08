import '../config/config.dart';

class LOG {
  static debug(String message) {
    if (Config.envType != EnvType.release) {
      printMessage(message);
    }
  }

  static d(String message) {
    printMessage(message);
  }

  static info(String message) {
    printMessage(message);
  }

  static warn(String message) {
    printMessage(message);
  }

  static error(String message) {
    printMessage(message);
  }

  static printMessage(String message) {
    if (Config.envType != EnvType.release) {
      // Logger logger = Logger();
      // logger.d("${Config.logPrefix}${message}");
      print("${Config.logPrefix}${message}");
    }
  }
}
