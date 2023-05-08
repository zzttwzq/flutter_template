import 'package:app/api/network_request.dart';
import 'package:dio/dio.dart';

import '../utils/storage_util.dart';
import 'api_url.dart';

/// 用户相关接口
class UserReq {
  ///登录接口 - 邮箱登录 POST
  static Future loginRequest({dynamic params}) async {
    final response = await NetworkRequest.instance.post(ApiUrl.login,
        // data: FormData.fromMap(data.toMap()), loading: true);
        data: FormData.fromMap({
          "recipient": params['email'] ?? '',
          "code": params['password'],
          "recipientType": params['recipientType'] ?? 'EMAIL',
          "machineCode": params['machineCode'] ?? '',
          "loginType": params['loginType'] ?? 'PASSWORD',
          "platform": params['platform'] ?? 'pw',
        }),
        loading: true);

    return response.data;
  }

  ///登出接口 POST
  static Future logoutRequest({dynamic params}) async {
    return await NetworkRequest.instance.post(ApiUrl.logout,
        data: FormData.fromMap({
          "platform": 'pw',
        }),
        loading: true);
  }

  ///获取用户信息 POST
  static Future getUserInfoRequest() async {
    final response = await NetworkRequest.instance
        .post(ApiUrl.userInfo, data: FormData.fromMap({}), loading: true);
    return response.data;
  }

  ///更新用户信息 POST
  /// recipient: ylu601@163.com
  /// recipientType: EMAIL
  /// checkType: REGISTER
  static Future checkUserExistRequest({dynamic params}) async {
    final response = await NetworkRequest.instance.post(ApiUrl.checkUserExist,
        data: FormData.fromMap({
          "recipient": params['recipient'] ?? '',
          "recipientType": params['recipientType'] ?? 'EMAIL',
          "checkType": params['checkType'] ?? 'REGISTER',
        }),
        loading: true);
    return response.data;
  }

  ///更新用户信息 POST
  static Future updateUserInfoRequest({dynamic params}) async {
    return await NetworkRequest.instance.post(ApiUrl.updateUserInfo,
        data: FormData.fromMap({
          "name": params['name'] ?? '',
          "avatarType": params['avatarType'] ?? '',
        }),
        loading: true);
  }

  ///更新用户头像 POST
  static Future updateUserAvatarRequest({dynamic params}) async {
    return await NetworkRequest.instance.post(ApiUrl.updateUserAvatar,
        data: FormData.fromMap({
          "avatar": params['avatar'],
        }),
        loading: true);
  }

  ///获取用户信息 POST
  static Future getShareCodeRequest() async {
    final response = await NetworkRequest.instance
        .post(ApiUrl.userShareCode, data: FormData.fromMap({}), loading: true);
    return response.data;
  }

  ///第三方登录-微信登录
  ///生成二维码接口
  static Future getWXCodeRequest({dynamic params}) async {
    final response = await NetworkRequest.instance
        .get(ApiUrl.wechatCode, params: params, loading: true);
    return response.data;
  }

  ///微信登录回调接口
  ///Code
  static Future getWXLoginRequest({dynamic params}) async {
    final response = await NetworkRequest.instance.get(ApiUrl.wechatLogin,
        params: {
          "code": params['code'],
        },
        loading: true);
    return response.data;
  }

  ///发送邀请码
  static Future sendVerificationRequest({dynamic params}) async {
    String s = await StorageUtil.getString('language_code');
    s = s.toLowerCase();

    final response = await NetworkRequest.instance.post(ApiUrl.sendVerification,
        data: FormData.fromMap({
          "verificationPhaseType": params['verificationPhaseType'] ?? '',
          "email": params['email'] ?? '',
          "mobile": params['mobile'] ?? '',
          "clientType": 'web',
          "language": s
        }),
        loading: true);
    return response.data;
  }

  ///校验邀请码
  static Future checkVerificationRequest({dynamic params}) async {
    final response = await NetworkRequest.instance.post(ApiUrl.checkVerification,
        data: FormData.fromMap({
          "recipient": params['recipient'] ?? '',
          "validationCode": params['validationCode'] ?? '',
        }),
        loading: true);
    return response.data;
  }

  ///注册
  static Future registerRequest({dynamic params, dynamic? headers}) async {
    final response = await NetworkRequest.instance.post(ApiUrl.register,
        data: FormData.fromMap(
          {
            "recipientType": params['recipientType'] ?? 'EMAIL',
            "recipient": params['recipient'] ?? '',
            "password": params['password'] ?? '',
            "validationCode": params['validationCode'] ?? '',
            "name": params['name'] ?? '',
            "teamName": params['teamName'] ?? '',
            "openId": params['openId'] ?? '',
            "platform": 'pw'
          },
        ),
        headers: headers,
        loading: true);
    return response.data;
  }

  /// 找回密码
  /// @param recipientType {String} 账户类型, ['EMAIL', 'MOBILE']
  /// @param recipient {String} 邮箱地址或手机号
  /// @param validationCode {Number} 验证码
  /// @param password {String} 新的登录密码
  static Future retrievePasswordRequest({dynamic params}) async {
    final response = await NetworkRequest.instance.post(ApiUrl.retrievePassword,
        data: FormData.fromMap({
          "recipientType": params['recipientType'] ?? 'EMAIL',
          "recipient": params['recipient'] ?? '',
          "validationCode": params['validationCode'] ?? '',
          "password": params['password'] ?? '',
        }),
        loading: true);
    return response.data;
  }

  ///修改密码
  static Future changePasswordRequest({dynamic params}) async {
    final response = await NetworkRequest.instance.post(ApiUrl.changePassword,
        data: FormData.fromMap({
          "oldPassword": params['oldPassword'] ?? '',
          "newPassword": params['newPassword'] ?? '',
        }),
        loading: true);
    return response.data;
  }

  static Future postJson(String jsonString) async {
    await Dio().post("http://192.168.16.103:8000/blog/learn/learn_list", data: {
      'json_string': jsonString
    });
  }
}
