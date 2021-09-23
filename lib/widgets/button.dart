import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  
  String _title = '';
  Function()? _func;
  bool _isEnable = true;
  
  Button(String title, Function()? func, {bool isEnable = true}) {
    _title = title;
    _func = func;
    _isEnable = isEnable;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: 50,
      decoration: BoxDecoration(
          // border: Border.all(color: Colors.red, width: 1, ),
          borderRadius: BorderRadius.all(Radius.circular(16)),
          boxShadow: _isEnable ? [
            BoxShadow(
              color: theme.colorScheme.primary.withOpacity(0.2),
              spreadRadius: 0,
              blurRadius: 20,
              offset: Offset(0, 10), // changes position of shadow
            ),
          ] : null,
      ),
      child: TextButton(
        onPressed: _isEnable ? _func : null,
        style: TextButton.styleFrom(
          primary: theme.colorScheme.background,
          backgroundColor: _isEnable ? theme.colorScheme.primary : theme.colorScheme.background,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: Text(_title, 
          style: theme.textTheme.button?.copyWith(
            color: _isEnable ? Colors.white : theme.colorScheme.onBackground,
          ),
        ),
      ),
    );
  }
}