import 'dart:io';
import 'package:app/utils/toast_util.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;

import '../config/config.dart';

/// 返回状态码
class HttpResponseCode {
  static const int successCode = 0;
  static const int errorCode = -1000;
  static const int logoutCode = 401;

  static const int connectTimeout = 6001;
  static const int receiveTimeout = 6002;
}

/// http请求方法
class HttpMethod {
  static const String get = "GET";
  static const String post = "POST";
  static const String put = "PUT";
  static const String delete = "DELETE";
  static const String option = "OPTION";
}

/// http请求contnettype
class HttpContentType {
  static const String form = "application/x-www-form-urlencoded";
  static const String formData = "multipart/form-data";
  static const String json = "application/json";
  static const String text = "text/xml";
}

/// 请求工具类
class HttpUtil {
  static proxyRequest(Dio dio, bool proxyOn, String ipString) {
    if (proxyOn) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.findProxy = (uri) {
          // return "PROXY 192.168.1.113:8888";
          return "PROXY $ipString:8888";
        };
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return null;
      };
    }
  }

  /// 获取请求头
  static Future<Map<String, dynamic>> getRequestHeader({
    String contentType = Config.defaultContentType,
  }) async {
    Map<String, dynamic> headers = {};

    // headers['os'] = await DeviceInfoUtil.getOs();
    // headers['app_version'] = await DeviceInfoUtil.getVersion();
    // headers['timestamp'] = DateTime.now().millisecondsSinceEpoch.toString();
    // headers['device'] = await DeviceInfoUtil.getDeivceName();
    // headers['app_store'] = DeviceInfoUtil.getChannelName();
    headers['content-type'] = contentType;
    // headers['mac'] = '';
    // if (Get.isRegistered<UserStore>() && UserStore.to.hasToken == true) {
    //   headers['x-authorization'] = UserStore.to.token;
    // }

    return headers;
  }

  /// 请求成功全局处理
  static Response onSuccess(Response? res) {
    Response successResponse = res ??
        Response(
            statusCode: HttpResponseCode.errorCode,
            requestOptions: RequestOptions(path: ""));

    return successResponse;
  }

  /// 请求失败全局处理
  static Response onError(DioError error) {
    // 请求错误处理
    Response errorResponse = error.response ??
        Response(
            statusCode: HttpResponseCode.errorCode,
            requestOptions: RequestOptions(path: ""));

    switch (error.type) {
      case DioErrorType.connectTimeout: // 请求超时
        errorResponse.statusCode = HttpResponseCode.connectTimeout;
        errorResponse.statusMessage = "network-tips-connect_timeout".tr;
        break;
      case DioErrorType.receiveTimeout: // 请求连接超时
        errorResponse.statusCode = HttpResponseCode.receiveTimeout;
        errorResponse.statusMessage = "network-tips-receive_timeout".tr;
        break;
      case DioErrorType.response: // 服务器内部错误
        errorResponse.statusCode = error.response?.statusCode;
        errorResponse.statusMessage = "network-tips-server_busy".tr;
        break;
      case DioErrorType.cancel: // 请求取消
        errorResponse.statusCode = error.response?.statusCode;
        errorResponse.statusMessage = "network-tips-cancel".tr;
        break;
      case DioErrorType.other: // 其他错误
        errorResponse.statusCode = error.response?.statusCode;
        errorResponse.statusMessage = "network-tips-other".tr;
        break;
      default:
    }

    /// 添加错误提示
    ToastUtil.toast(errorResponse.statusMessage ?? "");

    /// 返回错误
    return errorResponse;
  }
}
