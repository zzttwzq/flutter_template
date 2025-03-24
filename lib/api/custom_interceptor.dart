import 'dart:convert';
import 'package:app/router/app_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutterbase/flutterbase.dart';
import 'package:flutterbase/utils/http_util.dart';

import '../config/config.dart';
import '../localization/Translate.dart';

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
      LogUtil.debug('');
      LogUtil.debug('[=========== ${response.requestOptions.path} ==========]');
      LogUtil.debug('[ URL    ]：${response.requestOptions.baseUrl + response.requestOptions.path}');
      LogUtil.debug('[ METHOD ]：${response.requestOptions.method}');
      LogUtil.debug('[ HEADER ]：${json.encode(response.requestOptions.headers.toString())}');
      LogUtil.debug('[ PARAMS ]：${json.encode(response.requestOptions.queryParameters.toString())}');
      var d = response.requestOptions.data;
      if (d is FormData) {
        LogUtil.debug('[ DATA  ]：${d.fields.toString()}');
      } else {
        LogUtil.debug('[ DATA  ]：${response.requestOptions.data.toString()}');
      }
      LogUtil.debug('[ SUCCESS ]');
      LogUtil.debug('[ RESULT  ]：${json.encode(response.data.toString())}');
      LogUtil.debug('[========================================]');
      LogUtil.debug('');
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
        HudUtil.toast(Translate.cancel.tr);
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
        HudUtil.error(msg);
      }

      handler.reject(
          DioError(requestOptions: response.requestOptions, error: msg));
    }
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (Config.logRequest && kDebugMode) {
      LogUtil.debug('');
      LogUtil.debug('[=========== ${err.requestOptions.path} ==========]');
      LogUtil.debug('[ URL    ]：${err.requestOptions.baseUrl + err.requestOptions.path}');
      LogUtil.debug('[ METHOD ]：${err.requestOptions.method}');
      LogUtil.debug('[ HEADER ]：${json.encode(err.requestOptions.headers.toString())}');
      LogUtil.debug('[ PARAMS ]：${json.encode(err.requestOptions.queryParameters.toString())}');
      var d = err.requestOptions.data;
      if (d is FormData) {
        LogUtil.debug('[ DATA  ]：${d.fields.toString()}');
      } else {
        LogUtil.debug('[ DATA  ]：${err.requestOptions.data.toString()}');
      }
      LogUtil.debug('[ *ERROR* ]');
      LogUtil.debug('[ ERROR  ]：${err}');
      LogUtil.debug('[========================================]');
      LogUtil.debug('');
    }

    /// 公共处理失败请求
    HttpUtil.onError(err);

    handler.next(err);
  }
}
