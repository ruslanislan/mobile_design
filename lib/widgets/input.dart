import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:RDSH/rdsh_icons_icons.dart';
import 'package:RDSH/widgets/button_link.dart';
import 'package:RDSH/widgets/button.dart';
import 'package:RDSH/cache.dart' as cache;
import 'package:RDSH/models/user.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart'; 
import 'dart:async';

class Input extends StatefulWidget {
  bool? withoutRequest;
  bool? withErrorButton;
  String? label;
  String? type;
  TextEditingController? controller;
  Future<String?>? Function()? onReady; //TODO: заменить на массив валидаторов
  Input({Key? key, this.label, this.type, this.withoutRequest = false, this.withErrorButton = false, this.onReady, this.controller }) : super(key: key);
  var appName;
  var appDescription;

  @override
  _InputWidget createState() => _InputWidget();
}

class _InputWidget extends State<Input> {

  TextEditingController? _controller;
  ThemeData? theme;
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = false;
  Color? _iconColor;
  bool _isError = false;
  String? _oldValue; 
  String? _textError;
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  DateTime initDate = DateTime.now().subtract(Duration(days: 4380));
  
  @override
  initState() {
    _obscureText = widget.type! == 'password' ? true : false;
    _controller = widget.controller ?? new TextEditingController();
  }

  _showDatePicker() {
    showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      context: context, 
      builder: (BuildContext context) {
      return Container(
        margin: EdgeInsets.only(left: 15, right: 15),
        height: 390,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                color: theme?.colorScheme.background,
              ),
              height: 300,
              child: Stack(
                children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Text('Выберите дату рождения', 
                          textAlign: TextAlign.center,
                          style: theme?.textTheme.bodyText2!.copyWith(
                            color: theme?.colorScheme.onBackground,
                        )),
                      ),
                    ),
                    CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                      onDateTimeChanged: (date) => {
                        _controller!.text = formatter.format(date).toString()
                      },
                      initialDateTime: initDate,
                      minimumYear: 2001,
                      maximumYear: 2021,
                    ),
                ]
              )
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                color: theme?.colorScheme.background,
              ),
              height: 50,
              child: ButtonLink('Выбрать', () => {
                Navigator.pop(context)
              }), 
            )
          ],
        )
      );
    });
  }

  List<TextInputFormatter>? getFormatter(String type) {
    switch(type) {
      case 'date':
        return [new MaskTextInputFormatter(mask: '##/##/####', filter: { "#": RegExp(r'[0-9]') })];
      case 'phone':
        return [new MaskTextInputFormatter(mask: '+# (###) ###-##-##', filter: { "#": RegExp(r'[0-9]') })];
      default: 
    }
  }

  String? getHint(String type) {
    switch(type) {
      case 'date':
        return 'ДД/ММ/ГГГГ';
      case 'phone':
        return '+7 (XXX) XXX-XX-XX';
      default: 
    }
  }

  IconButton? getIcon(String type) {
    switch(type) {
      case 'password':
        return IconButton(
          onPressed: () => {
            setState(() => {
              _obscureText = !_obscureText,
            })
          },
          icon: Icon(RdshIcons.eye_close, color: _iconColor, size: 20),
        );
      case 'date':
        return IconButton(
          onPressed: () {
            _showDatePicker();
          },
          icon: Icon(RdshIcons.calendar, color: _iconColor, size: 20),
        );
      default: 
    }
  }

  TextInputType? getType(String type) {
    switch(type) {
      case 'email': 
        return TextInputType.emailAddress; 
      case 'phone':
        return TextInputType.phone;
      case 'number':
        return TextInputType.number;
      case 'date':
        return TextInputType.datetime;
      case 'password':
        return TextInputType.text;
      default: 
        return TextInputType.text;
    }
  }

   Future<String?> _getValidator (String type, String value) async {
    print('1');
    if (_oldValue != value) {
      setState(
        () => _oldValue = value
      );
    }
    switch(type) {
      case 'email': 
        if (value.isEmpty) {
          return 'Email не может быть пустым';
        }
        Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
        RegExp regex = new RegExp(pattern.toString());
        if (!regex.hasMatch(value)) {
          return 'Введите валидный email адрес';
        }
        cache.user?.email = value;
        if (!widget.withoutRequest!) {
          final errorText = widget.onReady!();
          if (errorText != null) {
            print('LOG input:188 : ${errorText}'); 
            return errorText;
          }
        }
        return null; 
      case 'phone':
        cache.user?.phone = value;
        return null;
      case 'number':
        return null;
      case 'date':
        if (value.length == 9) {
          return 'Введите валидный email адрес';
        }
        return null;
      case 'password':
        if (value.isEmpty) {
          return 'Пароль не может быть пустым';
        }
        cache.user?.hashPassword = value;
        if (widget.withErrorButton!) {
          setState(() => {
            _isError = true
          });
          return 'Неверный пароль.';
        }
        if (!widget.withoutRequest!) {
          final errorText = widget.onReady!();
          if (errorText != null) {
            return errorText;
          }
        }
        return null;
      default: 
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    var currentDateTime = DateTime.now();
    if(_obscureText) {
      setState(() => _iconColor = theme!.colorScheme.onBackground);
    } else {
      setState(() => _iconColor = theme!.colorScheme.primary);
    }
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return TextFormField(
      controller: _controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters: getFormatter(widget.type!),
      obscureText: _obscureText,
      keyboardType: getType(widget.type!),
      style: theme?.textTheme.bodyText2?.copyWith(
        color: theme?.colorScheme.secondary,
      ),
      decoration: InputDecoration(
        hintText: getHint(widget.type!),
        counter: _isError && widget.type! == 'password' ? 
          Container(
            margin: EdgeInsets.only(right: 85), 
            child: ButtonLink(
              'Забыли пароль?', 
              () => {
                Navigator.pushNamed(context, '/recovery_password')
              }, 
              type: 'link', isCover: false)
          ) : null,
        hintStyle: theme?.textTheme.subtitle2?.copyWith(
          color: theme?.colorScheme.onBackground,
        ),
        errorStyle: theme?.textTheme.bodyText1?.copyWith(
          color: theme?.colorScheme.error,
        ),
        suffixIcon: getIcon(widget.type!),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: theme!.colorScheme.primary, width: 2.0),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: theme!.colorScheme.background, width: 2.0),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: theme!.colorScheme.error, width: 2.0),
        ),
        labelText: widget.label,
        labelStyle: theme?.textTheme.subtitle2?.copyWith(
          color: theme!.colorScheme.onBackground,
        ),
      ),
      validator: (_) => _textError,
      onChanged: (value) async { 
        final text = await _getValidator(widget.type!, value);
        setState(() => _textError = text ?? null);
      },
    );
  }
}