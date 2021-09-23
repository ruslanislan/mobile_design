import 'dart:convert';

import 'package:RDSH/api_config.dart';
import 'package:RDSH/models/app_state.dart';
import 'package:RDSH/store/auth.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:RDSH/cache.dart' as cache;

enum APIMethod {
  GET,
  POST,
  PUT,
  DELETE,
  PATCH,
}
class APIRequest {
  static late APIRequest instance;
  final Store<AppState> store;
  APIRequest(this.store);

  getFullUrl(String path) {
    String port = APIConfig.port != null ? ':${APIConfig.port}' : '';
    String basepath = APIConfig.basePath != '' ? '${APIConfig.basePath}' : '';
    return APIConfig.basePath != '' ? '${APIConfig.url}$port/$basepath/$path' : '${APIConfig.url}$port/$path';
  }


  send(String path, APIMethod method, {Map<String, dynamic>? data, Map<String, String>? headers, bool useToken = true}) async {
    // Готовим headers ------------------------------------------------------------
    var _headers = { 'Content-Type': 'application/json; charset=UTF-8'};
    _headers.addAll(headers ?? {});
    if (useToken 
        && (store.state.auth.accessToken?.isNotEmpty ?? false) 
        && (store.state.auth.tokenType.isNotEmpty)
    ) {
      _headers.addAll({'Authorization': '${store.state.auth.tokenType} ${store.state.auth.accessToken}'});
    }
    if (useToken
      && (store.state.auth.accessToken?.isNotEmpty ?? false)
    ) {
      _headers.addAll({'X-RDSH-AUTH-TOKEN': store.state.auth.accessToken!});
    }
    print('store.state.auth.id ${store.state.auth.id}');
    print('store.state.auth.email ${store.state.auth.email}');
    print('cache.user.id ${cache.user!.id}');
    if (store.state.auth.id != null) {
      _headers.addAll({'X-RDSH-ACCOUNT-ID': store.state.auth.id.toString()});
    }

    // Готовим headers ------------------------------------------------------------
    try {
      http.Response response = await _sendRequest(path, method, data:data, headers:_headers);
      // Логируем результат запроса ------------------------------------------------------------
      if (APIConfig.logging) {
        print('RESPONSE START -----------------------------------------');
        print('RESPONSE STATUS = ${response.statusCode}');
        print('RESPONSE DATA = ${response.body}');
        print('RESPONSE HEADERS =${jsonEncode(response.headers)}');
        print('RESPONSE END -------------------------------------------\n\n');
      }
      
      switch (response.statusCode) {
        case 200:
        case 201: 
          dynamic responseData = json.decode(response.body);
          if (response.headers.containsKey(APIConfig.tokenHeader.toLowerCase())) {
            store.dispatch(
              AuthUpdateAction(
                state:AuthState(
                  accessToken: response.headers[APIConfig.tokenHeader.toLowerCase()],
                  expireIn: response.headers['expires-in'],
                  name: response.headers['name']
                )
              )
            );
          }
          
          return {'data': responseData, 'statusCode': response.statusCode};
        case 401:
          if (useToken)  {
            store.dispatch(authSingOut(sendRequest:false)); 
          }
          return {
            'error':'Не авторизован',
            'code':401,
            'statusCode':response.statusCode
          };
        default: 
          return {
            'error':'Неизвестная ошибка',
            'code':response.statusCode,
            'statusCode':response.statusCode
          };
      }
    } catch(err) {
      // Логируем ошибку ------------------------------------------------------------
      if (APIConfig.logging) {
        print('REQUEST ERROR !!!!!!!!!!!!!!!!!!!!!!!!!! ');
        print('REQUEST FAILED WITH ERROR ${err.toString()}');
        print('REQUEST ERROR END !!!!!!!!!!!!!!!!!!!!!!!! \n\n');
      }

      return {
        'error': err.toString(),
        'code': 500,
        'statusCode': 500
      }; 
    }
  }


  Future<http.Response> _sendRequest(String path, APIMethod method, {Map<String, dynamic>? data, Map<String, String>? headers}) async {
    Uri uri;
    if (method == APIMethod.GET) {
      uri = Uri.parse(getFullUrl(path));
      uri = uri.replace(queryParameters: data );
    } else {
      uri = Uri.parse(getFullUrl(path));
    }

    // Логируем запрос ------------------------------------------------------------
    if (APIConfig.logging) {
      print('REQUEST START ---------------------------- ');
      print('REQUEST METHOD = ${method.toString().split('.').last}');
      print('REQUEST PATH = $uri');
      print('REQUEST DATA = ${jsonEncode(data)}');
      print('REQUEST HEADERS = ${jsonEncode(headers)}');
      print('REQUEST END ------------------------- \n\n');
    }

    switch(method) {
      case APIMethod.GET:
        return await http.get(
          uri, 
          headers:headers,
        );
      case APIMethod.POST:
        return await http.post(
          uri, 
          headers:headers,
          body:jsonEncode(data)
        );
      case APIMethod.PUT:
        return await http.put(
          uri, 
          headers:headers,
          body:jsonEncode(data)
        );
      case APIMethod.DELETE:
        return await http.delete(
          uri, 
          headers:headers,
          body:jsonEncode(data)
        );
      case APIMethod.PATCH:
        return await http.patch(
          uri, 
          headers:headers,
          body:jsonEncode(data)
        );
    }
  }
}