import 'dart:math';
import 'package:flutter/material.dart';

extension StringExtension on String {

  static String generateRandomString(int length) {
    final random = Random();
    const availableChars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    final randomString = List.generate(length,
            (index) => availableChars[random.nextInt(availableChars.length)])
        .join();

    return randomString;
  }

  /// 验证密码
  bool isValidPassword(String? inputString, {bool isRequired = false}) {
    bool isInputStringValid = false;

    if ((inputString == null ? true : inputString.isEmpty) && !isRequired) {
      isInputStringValid = true;
    }

    if (inputString != null) {
      const pattern =
          r'^(?=.*?[A-Z])(?=(.*[a-z]){1,})(?=(.*[\d]){1,})(?=(.*[\W]){1,})(?!.*\s).{8,}$';

      final regExp = RegExp(pattern);

      isInputStringValid = regExp.hasMatch(inputString);
    }

    return isInputStringValid;
  }

  /// 是否是字符串，空字符串也不算
  bool isText({bool isRequired = false}) {
    bool isInputStringValid = false;

    if ((this == null ? true : this.isEmpty) && !isRequired) {
      isInputStringValid = true;
    }

    if (this != null) {
      const pattern = r'^[a-zA-Z]+$';

      final regExp = RegExp(pattern);

      isInputStringValid = regExp.hasMatch(this);
    }

    return isInputStringValid;
  }

  // 邮箱判断
   bool isEmail(String input) {
    String regexEmail = "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*\$";
    if (input.isEmpty) return false;
    return RegExp(regexEmail).hasMatch(input);
  }

   bool isContainOtherBytes(String input) {
    String regexBytes = "[!\\W]";
    return RegExp(regexBytes).hasMatch(input);
  }

   bool checkNameReg(String input) {
    String regexName = "^[\\u4E00-\\u9FA5\\sA-Za-z0-9_]+\$";
    if (input.isEmpty) return false;
    return RegExp(regexName).hasMatch(input);
  }

   bool checkPasswordReg(String input) {
    String regexPassword =
        "^(?=.*\\d)(?=.*[a-zA-Z])[\\da-zA-Z~!@#\$%^&*()_+]{6,20}\$";
    if (input.isEmpty) return false;
    return RegExp(regexPassword).hasMatch(input);
  }

   Size boundingTextSize(String text, TextStyle style,
      {int maxLines = 2 ^ 31, double maxWidth = double.infinity}) {
    if (text == null || text.isEmpty) {
      return Size.zero;
    }
    final TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(text: text, style: style),
    )..layout(maxWidth: maxWidth);
    return textPainter.size;
  }
}
