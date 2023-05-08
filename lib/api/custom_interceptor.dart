import 'dart:convert';
import 'package:app/router/app_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../config/config.dart';
import '../localization/Translate.dart';
import '../utils/c_log_util.dart';
import '../utils/http_util.dart';
import '../utils/toast_util.dart';

class CustomInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    /// 加载请求头
    Map<String, dynamic> headers = await HttpUtil.getRequestHeader();
    headers['content-type'] = options.contentType;
    options.headers.addAll(headers);

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (Config.logRequest && kDebugMode) {
      LOG.d('');
      LOG.d('[=========== ${response.requestOptions.path} ==========]');
      LOG.d('[ URL    ]：${response.requestOptions.baseUrl + response.requestOptions.path}');
      LOG.d('[ METHOD ]：${response.requestOptions.method}');
      LOG.d('[ HEADER ]：${json.encode(response.requestOptions.headers.toString())}');
      LOG.d('[ PARAMS ]：${json.encode(response.requestOptions.queryParameters.toString())}');
      var d = response.requestOptions.data;
      if (d is FormData) {
        LOG.d('[ DATA  ]：${d.fields.toString()}');
      } else {
        LOG.d('[ DATA  ]：${response.requestOptions.data.toString()}');
      }
      LOG.d('[ SUCCESS ]');
      LOG.d('[ RESULT  ]：${json.encode(response.data.toString())}');
      LOG.d('[========================================]');
      LOG.d('');
    }

    /// 可以在此处处理加密
    if (response.data is String) {
      response.data = json.decode(response.data);
    }

    if (response.data['code'] != null &&
        int.parse(response.data['code']) == 0) {
      /// 公共处理成功请求
      HttpUtil.onSuccess(response);

      handler.next(response);
    } else if (response.data['status'] != null) {
      debugPrint('图片上传oss成功！');

      /// 公共处理成功请求
      HttpUtil.onSuccess(response);

      handler.next(response);
    } else {
      if (int.parse(response.data['code']) == 300) {
        ToastUtil.toast(Translate.toastReLogin);
        AppRoute.gotoPage(AppRoute.loginPage);
      }

      if (int.parse(response.data['code']) == 8000) {
        HttpUtil.onSuccess(response);
        handler.next(response);
      }
      String msg = response.data != null && response.data['msg'] != null
          ? response.data['msg']
          : "";

      if (msg.isNotEmpty) {
        ToastUtil.error(msg);
      }

      handler.reject(
          DioError(requestOptions: response.requestOptions, error: msg));
    }
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (Config.logRequest && kDebugMode) {
      LOG.d('');
      LOG.d('[=========== ${err.requestOptions.path} ==========]');
      LOG.d('[ URL    ]：${err.requestOptions.baseUrl + err.requestOptions.path}');
      LOG.d('[ METHOD ]：${err.requestOptions.method}');
      LOG.d('[ HEADER ]：${json.encode(err.requestOptions.headers.toString())}');
      LOG.d('[ PARAMS ]：${json.encode(err.requestOptions.queryParameters.toString())}');
      var d = err.requestOptions.data;
      if (d is FormData) {
        LOG.d('[ DATA  ]：${d.fields.toString()}');
      } else {
        LOG.d('[ DATA  ]：${err.requestOptions.data.toString()}');
      }
      LOG.d('[ *ERROR* ]');
      LOG.d('[ ERROR  ]：${err}');
      LOG.d('[========================================]');
      LOG.d('');
    }

    /// 公共处理失败请求
    HttpUtil.onError(err);

    handler.next(err);
  }
}
