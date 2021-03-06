// import 'package:dio/dio.dart' show Interceptor, RequestInterceptorHandler, RequestOptions, Response;
// import 'package:flutter_code_test/utils/local_storage.dart';
// import 'package:flutter_code_test/utils/local_storage_keys.dart';
//
// class TokenInterceptors extends Interceptor {
//   String _token;
//
//
//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) async{
//     if (_token == null) {
//       var authorizationCode = await getAuthorization();
//       if (authorizationCode != null) {
//         _token = authorizationCode;
//       }
//     }
//     options.headers['Authorization'] = _token;
//   }
//
//   @override
//   onResponse(Response response) async {
//     try {
//       var responseJSON = response.data;
//       if (response.statusCode == 201 && responseJSON['token'] != null) {
//         _token = 'token ' + responseJSON['token'];
//         await LocalStorage.set(LocalStorageKeys.TOKEN_KEY, _token);
//       }
//     } catch (e) {
//       print(e);
//     }
//     return response;
//   }
//
//   getAuthorization() async {
//     String token = await LocalStorage.get(LocalStorageKeys.TOKEN_KEY);
//     if (token == null) {
//     } else {
//       this._token = token;
//       return token;
//     }
//   }
//
//   clearAuthorization() {
//     this._token = null;
//     LocalStorage.remove(LocalStorageKeys.TOKEN_KEY);
//   }
// }
