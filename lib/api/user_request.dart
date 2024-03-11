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
}
