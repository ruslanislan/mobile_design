import 'dart:async';
import 'dart:convert';

import 'package:RDSH/models/user.dart';
import 'package:RDSH/utils/api_request.dart';
import 'package:http/http.dart' as http;
import 'package:RDSH/models/app_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:RDSH/cache.dart' as cache;

// Класс хранит состояние по авторизации
class AuthState {
  String? accessToken;
  String? expireIn;
  String? name;
  int? id;
  String? email;
  String? refreshToken;
  String? signInError;
  String tokenType;
  List<String> errorFields;
  
  AuthState({
    this.accessToken,
    this.expireIn,
    this.id,
    this.name,
    this.email,
    this.refreshToken,
    this.signInError,
    this.errorFields = const [],
    this.tokenType = 'bearer',
  });

  AuthState copyWith({
    int? id, 
    String? accessToken, 
    String? expireIn, 
    String? name,
    String? email,
    String? refreshToken,
    String? tokenType,
    String? signInError,
    List<String>? errorFields,
  }) {
    return new AuthState(
      accessToken: accessToken ?? this.accessToken,
      expireIn: expireIn ?? this.expireIn,
      name: name ?? this.name,
      id: id ?? this.id,
      email: email ?? this.email,
      refreshToken: refreshToken ?? this.refreshToken,
      tokenType: tokenType ?? this.tokenType,
      signInError: signInError ?? this.signInError,
      errorFields: errorFields ?? this.errorFields,
    );
  }
}

abstract class AuthAction {
  String toString() {
    return '$runtimeType';
  }
}

// Класс от которого будут наследоватся все другие экшены, используется чисто для того чтобы сравнивать тип 
class AuthUpdateTokenAction extends AuthAction {
  final String accessToken;
  AuthUpdateTokenAction({
    required this.accessToken,
  });
}

// TODO: для чего он нужен?
class AuthSignInErrorAction extends AuthAction {
  final String signInError;
  final List<String> errorFields;
  AuthSignInErrorAction({
    required this.signInError,
    required this.errorFields,
  });
}

// просто экшен для удаление токена, будет использоватся во время signup
class AuthDeleteTokenAction extends AuthAction {
}


class AuthUpdateAction extends AuthAction {
  AuthState state;
  AuthUpdateAction({
    required this.state,
  });
}

class AuthViewModel {
  final int? id;
  final String? name;
  final String? email;
  final String? signInError;
  final List<String> errorFields;

  final Function(String, String) signIn;

  AuthViewModel({
    this.id,
    this.name,
    this.email,
    this.signInError,
    this.errorFields = const [],
    required this.signIn
  });

  static AuthViewModel fromStore(Store<AppState> store) {
    return AuthViewModel(
      id: store.state.auth.id,
      name: store.state.auth.name,
      email: store.state.auth.email,
      signInError: store.state.auth.signInError,
      errorFields: store.state.auth.errorFields,
      signIn: (String username, String password) {
        store.dispatch(authSingIn(username, password));
      },
    );
  }
}

AuthState authReducer(AuthState state, AuthAction action) {

  if (action is AuthUpdateTokenAction) {
    return state.copyWith(accessToken:action.accessToken);
  }

  if (action is AuthDeleteTokenAction) {
    return state.copyWith(accessToken:null);
  }

  if (action is AuthUpdateAction) {
    return state.copyWith(
      id:action.state.id,
      accessToken:action.state.accessToken,
      expireIn:action.state.expireIn,
      name:action.state.name,
      email:action.state.email,
      refreshToken:action.state.refreshToken,
    );
  }

  if (action is AuthSignInErrorAction) {
    return state.copyWith(signInError:action.signInError, errorFields:action.errorFields);
  }

  return state;
}

ThunkAction<AppState> authSingIn(String email, String password) {
  return (Store<AppState> store) async {
    try {
      var response = await APIRequest.instance.send('login/', APIMethod.POST, data:{'session': {
        'email':email,
        'password':password
      }});
      if (response['statusCode'] == 200) {
        var id = response['data']?['account']?['id'];
        store.dispatch(AuthUpdateAction(state: AuthState(email: email, id:id)));
      }
      return response;
    } catch(err) {
      return false;
    }
  };
}

ThunkAction<AppState> authEnterCode(String code) {
  return (Store<AppState> store) async {
    try {
      int? id;
      print(cache.user?.id);
      id = store.state.auth.id ?? cache.user?.id;
      if (id != null) {
        var response = await APIRequest.instance.send('account_activations/${id}/auth', APIMethod.POST, data:{
          'code': code,
        });
        return response;
      }
      print('code = $code, auth = ${id.toString()}');
      return false;
    } catch(err) {
      print(err);
      return false;
    }
  };
}

ThunkAction<AppState> authEmailCheck(String email) {
  return (Store<AppState> store) async {
    try {
      var response = await APIRequest.instance.send('check_account/', APIMethod.GET, data:{
        'email': email,
      });
      return response;
    } catch(err) {
      return false;
    }
  };
}

ThunkAction<AppState> authSingUp(User user) {
  return (Store<AppState> store) async {
    try {
      var response = await APIRequest.instance.send('signup/', APIMethod.POST, data:{
        'account': {
            'email': user.email,
        }
      });
      int? id = response['data']?['account']?['id'];
      print('response[data]?[account]?[id] - ${response['data']?['account']?['id']}');
      store.dispatch(AuthUpdateAction(state: AuthState(email: user.email, id: id)));
      print('store.state.auth.email ${store.state.auth.email}');
      return response;
    } catch(err) {
      print('err = $err');
      return false;
    }
  };
}

ThunkAction<AppState> authSingOut({bool sendRequest = true}) {
  return (Store<AppState> store) async {
    if (sendRequest) { 
      var response = await APIRequest.instance.send('logout', APIMethod.PUT);
    }
  };
}

ThunkAction<AppState> authPasswordReset(User user) {
  return (Store<AppState> store) async {
    try {
      print('store.state.auth.email ${store.state.auth.email}');
      var response = await APIRequest.instance.send('reset/', APIMethod.POST, data:{
        'account': {
            'password': user.hashPassword,
            'password_confirmation': user.hashPassword,
        }
      });
      return response;
    } catch(err) {
      print('err = $err');
      return false;
    }
  };
}

ThunkAction<AppState> authUserUpdate(User user) {
  return (Store<AppState> store) async {
    try {
      var response = await APIRequest.instance.send('users/${store.state.auth.id}', APIMethod.PATCH, data:{
        'user': {
          'role': user.typeAccount,
          'first_name': user.name,
          'last_name': user.secondName,
          'patronymic': user.lastName,
          'date_of_birthday': user.dateBirthday,
          'locality': user.schoolLocation?.city,
          'region': user.schoolLocation?.region,
          'school': user.schoolLocation?.title,
        }
      });
      return response;
    } catch(err) {
      print('err = $err');
      return false;
    }
  };
}

ThunkAction<AppState> authAccountUpdate(User user) {
  return (Store<AppState> store) async {
    try {
      var response = await APIRequest.instance.send('accounts/${store.state.auth.id}', APIMethod.PATCH, data:{
        'account': {
          'password': user.hashPassword,
          'password_confirmation': user.hashPassword,
        },
      });
      return response;
    } catch(err) {
      print('err = $err');
      return false;
    }
  };
}