// import 'dart:io';

import 'package:dio/dio.dart';

import '../config/config.dart';
import '../utils/http_util.dart';
import '../utils/toast_util.dart';
import 'custom_interceptor.dart';

class NetworkRequest {
  static late NetworkRequest _instance;
  static bool _isInstanceCreated = false;
  static Dio? _dio;

  factory NetworkRequest() => getInstance();
  static NetworkRequest get instance => getInstance();
  static NetworkRequest getInstance() {
    if (_isInstanceCreated == false) {
      _instance = NetworkRequest._internal();
    }
    _isInstanceCreated = true;
    return _instance;
  }

  NetworkRequest._internal() {
    if (_isInstanceCreated == false) {
      var options = BaseOptions(
        baseUrl: Config.getBaseUrl(),
        connectTimeout: Config.connectTimeout,
        receiveTimeout: Config.requestTimeout,
      );
      _dio = Dio(options);

      /// 加载拦截器
      _dio?.interceptors.add(CustomInterceptor());
    }
  }

  /// get请求
  Future<Response> get(
    String path, {
    Map<String, dynamic>? params,
    bool? loading = false,
    String? contentType = Config.defaultContentType,
    Function(Response res)? onSuccess,
    Function(Response errRes)? onError,
  }) async {
    return request(path, HttpMethod.get,
        params: params,
        loading: loading,
        contentType: contentType,
        onError: onError,
        onSuccess: onSuccess);
  }

  /// post请求
  Future<Response> post(
    String path, {
    Map<String, dynamic>? params,
    dynamic data,
    bool? loading = false,
    Map<String, String>? headers,
    String? contentType = Config.defaultContentType,
    Function(Response res)? onSuccess,
    Function(Response errRes)? onError,
  }) async {
    return request(path, HttpMethod.post,
        params: params,
        headers: headers,
        data: data,
        loading: loading,
        contentType: contentType,
        onError: onError,
        onSuccess: onSuccess);
  }

  /// put请求
  Future<Response> put(
    String path, {
    Map<String, dynamic>? params,
    Map<String, dynamic>? data,
    bool? loading = false,
    String? contentType = Config.defaultContentType,
    Function(Response res)? onSuccess,
    Function(Response errRes)? onError,
  }) async {
    return request(path, HttpMethod.put,
        params: params,
        data: data,
        loading: loading,
        contentType: contentType,
        onError: onError,
        onSuccess: onSuccess);
  }

  /// delete请求
  Future<Response> delete(
    String path, {
    Map<String, dynamic>? params,
    Map<String, dynamic>? data,
    bool? loading = false,
    String? contentType = Config.defaultContentType,
    Function(Response res)? onSuccess,
    Function(Response errRes)? onError,
  }) async {
    return request(path, HttpMethod.delete,
        params: params,
        data: data,
        loading: loading,
        contentType: contentType,
        onError: onError,
        onSuccess: onSuccess);
  }

  /// option请求
  Future<Response> option(
    String path, {
    Map<String, dynamic>? params,
    Map<String, dynamic>? data,
    bool? loading = false,
    String? contentType = Config.defaultContentType,
    Function(Response res)? onSuccess,
    Function(Response errRes)? onError,
  }) async {
    return request(path, HttpMethod.option,
        params: params,
        loading: loading,
        contentType: contentType,
        onError: onError,
        onSuccess: onSuccess);
  }

  Future<Response> request(
    String path,
    String method, {
    dynamic data,
    Map<String, dynamic>? params,
    Map<String, String>? headers,
    String? contentType = Config.defaultContentType,
    bool? loading = false,
    Function(int count, int data)? onProgress,
    Function(Response res)? onSuccess,
    Function(Response errRes)? onError,
  }) async {
    _dio!.options.method = method;
    _dio!.options.headers['content-type'] = contentType;
    if (headers != null) {
      ///显示指定Map的限定类型 动态添加headers
      _dio!.options.headers.addAll(Map<String, String>.from(headers));
    }
    _dio!.options.contentType = contentType;
    Response response = Response(
        statusCode: HttpResponseCode.errorCode,
        requestOptions: RequestOptions(path: path));

    try {
      response = await _dio?.request(
            path,
            queryParameters: params,
            data: data,
            onSendProgress: onProgress,
          ) ??
          response;
      onSuccess?.call(response);
    } catch (e) {
      DioError err = DioError(
        requestOptions: RequestOptions(
            path: path, method: method, queryParameters: params, data: data),
        response: response,
        type: DioErrorType.response,
      );
      if (e is DioError) {
        err.type = e.type;
      }

      response.statusCode = err.response?.statusCode;
      response.data = err.response?.data;
      response.statusMessage = err.message;

      onError?.call(response);
    }
    ToastUtil.dismiss();

    return response;
  }
}
