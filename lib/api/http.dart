import 'dart:async' show Future;
import 'dart:collection' show HashMap;
import 'dart:convert';

import 'package:dio/dio.dart'
    show Dio, Options, DioError, Response, DioErrorType;
import 'package:flutter_code_test/global/constants.dart';

import './code.dart' show Code;
import './result_data.dart';

class HTTP {
  static const CONTENT_TYPE_JSON = 'application/json';
  static const CONTENT_TYPE_FROM = 'application/x-www-form-urlencoded';

  static HTTP? inst;

  static HTTP getInstance() {
    if (inst != null) {
      return inst!;
    }
    inst = new HTTP();
    return inst!;
  }

  Dio _dio = new Dio();

  HTTP() {
    // _dio.interceptors.add(new HeaderInterceptors());
    // // _dio.interceptors.add(_tokenInterceptors);
    // _dio.interceptors.add(new LogsInterceptors());
    // _dio.interceptors.add(new ErrorInterceptors(_dio));
    // _dio.interceptors.add(new ApiInterceptors());
  }

  Future<ResultData> request(
    String apiCode,
    data, {
    Map<String, dynamic>? headers,
    Options? options,
    isNoTip = false,
  }) async {
    Map<String, dynamic> _headers = new HashMap();
    if (headers != null) {
      _headers.addAll(headers);
    }

    if (options != null) {
      options.headers = _headers;
    } else {
      options = new Options(method: 'post');
      options.headers = _headers;
    }

    Response response;
    try {
      data["apiCode"] = apiCode;
      // 注意，所有data数据都要encode变为json字符串.
      response = await _dio.request(Constants.BASE_URL,
          data: json.encode(data), options: options);
    } on DioError catch (error) {
      return resultError(error, isNoTip);
    }

    if (response.data is DioError) {
      return resultError(response.data, isNoTip);
    }

    return response.data;
  }

  clearAuthorization() {
    // _tokenInterceptors.clearAuthorization();
  }

  resultError(DioError error, bool isNoTip) {
    Response errorResponse;
    if (error.response != null) {
      errorResponse = error.response!;
    } else {
      errorResponse =
          new Response(requestOptions: error.requestOptions, statusCode: 666);
    }

    if (error.type == DioErrorType.connectTimeout ||
        error.type == DioErrorType.receiveTimeout) {
      errorResponse.statusCode = Code.NETWORK_TIMEOUT;
    }

    return new ResultData(
      Code.errorHandleFunction(
        errorResponse.statusCode,
        error.message,
        isNoTip,
      ),
      false,
      errorResponse.statusCode!,
    );
  }
}

final HTTP http = HTTP.getInstance();

// 调用方法，完美
// Future _submit() async {
//   var params = Map<String, String>();
//   params["phone"] = '13812346666';
//   var res = await http.request(Api.GET_CODE, params);

//   if (res.data["code"] == 0) {
//     print('发送成功');
//   } else {
//     print(res.data["msg"]);
//   }
// }
