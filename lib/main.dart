import 'package:RDSH/constants/route_consts.dart';
import 'package:RDSH/models/app_state.dart';
import 'package:RDSH/pages/add_task_page.dart';
import 'package:RDSH/pages/dialog_page.dart';
import 'package:RDSH/store/reducers.dart';
import 'package:RDSH/utils/api_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:redux_thunk/redux_thunk.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final ThemeData theme = ThemeData();
  final store = Store<AppState>(
    appReducer,
    initialState: new AppState.initialState(),
    middleware: [
      thunkMiddleware,
      new LoggingMiddleware.printer(),
    ],
  );

  @override
  Widget build(BuildContext context) {
    APIRequest.instance = new APIRequest(store);
    return new StoreProvider(
        store: store,
        child: MaterialApp(
          title: '',
          theme: theme.copyWith(
            pageTransitionsTheme: PageTransitionsTheme(
              builders: {
                TargetPlatform.android: CupertinoPageTransitionsBuilder(),
                TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
              },
            ),
            colorScheme: theme.colorScheme.copyWith(
              primary: Color(0xff2858A5),
              secondary: Color(0xff272755),
              background: Color(0xffF1F3F9),
              error: Color(0xffDC2F14),
              onBackground: Color(0xff9393AA),
              onSurface: Color(0xffc2c2c2),
              secondaryVariant: Color(0xffA0A9B9),
            ),
            primaryTextTheme: theme.textTheme.copyWith(
              headline1: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 17,
                fontFamily: 'TT Norms',
                letterSpacing: -0.41,
                color: Color(0xFF272755), // TODO: добавление шрифтов
              ),
              headline2: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 13,
                fontFamily: 'TT Norms',
                letterSpacing: -0.08,
                color: Color(0xFF2858A5), // TODO: добавление шрифтов
              ),
              headline3: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                letterSpacing: -0.32,
                fontFamily: 'TT Norms',
                color: Color(0xFF272755), // TODO: добавление шрифтов
              ),
              headline4: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                letterSpacing: -0.32,
                fontFamily: 'TT Norms',
                color: Color(0xFF272755), // TODO: добавление шрифтов
              ),
              headline5: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
                letterSpacing: 0.38,
                fontFamily: 'TT Norms',
                color: Color(0xFF272755), // TODO: добавление шрифтов
              ),
              subtitle1: TextStyle(
                color: Color(0xFF272755),
                fontWeight: FontWeight.w500,
                fontSize: 15,
                letterSpacing: -0.24,
                fontFamily: 'TT Norms', // TODO: добавление шрифтов
              ),
              bodyText1: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                fontFamily: 'TT Norms', // TODO: добавление шрифтов
              ),
              bodyText2: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 15,
                letterSpacing: -0.24,
                fontFamily: 'TT Norms', // TODO: добавление шрифтов
              ),
              button: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                fontFamily: 'TT Norms', // TODO: добавление шрифтов
              ),
              caption: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 11,
                fontFamily: 'TT Norms', // TODO: добавление шрифтов
              ),
              overline: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                fontFamily: 'TT Norms',
                color: Colors.white,
                letterSpacing: 0.0, // TODO: добавление шрифтов
              ),
            ),
            textTheme: theme.textTheme.copyWith(
              headline2: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 24,
                fontFamily: 'SF Pro Text',
                letterSpacing: 0.0, // TODO: добавление шрифтов
              ),
              headline6: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 20,
                fontFamily: 'SF Pro Text', // TODO: добавление шрифтов
              ),
              headline3: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 17,
                fontFamily: 'SF Pro Text', // TODO: добавление шрифтов
              ),
              subtitle2: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                fontFamily: 'SF Pro Text', // TODO: добавление шрифтов
              ),
              bodyText1: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                fontFamily: 'SF Pro Text', // TODO: добавление шрифтов
              ),
              bodyText2: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
                fontFamily: 'SF Pro Text', // TODO: добавление шрифтов
              ),
              button: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                fontFamily: 'SF Pro Text', // TODO: добавление шрифтов
              ),
              caption: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 11,
                fontFamily: 'SF Pro Text', // TODO: добавление шрифтов
              ),
              overline: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                fontFamily: 'SF Pro Text',
                letterSpacing: 0.0, // TODO: добавление шрифтов
              ),
            ),
          ),
          home: AddTaskPage(),
          routes: <String, WidgetBuilder>{
            ADD_TASK_PAGE: (BuildContext context) => AddTaskPage(),
            DIALOG_PAGE: (_) => DialogPage(),
          },
        ));
  }
}
