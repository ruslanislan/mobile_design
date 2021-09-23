import 'package:flutter/material.dart';

class ButtonMini extends StatelessWidget {
  
  String? _title = '';
  Widget? _icon;
  Function()? _func;
  Color? _colorPrimary;
  
  ButtonMini({String? title, Function()? onTap, Widget? icon, Color? colorPrimary}) {
    _title = title;
    _func = onTap;
    _icon = icon;
    _colorPrimary = colorPrimary;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: _func,
      child: Container(
        height: 20,
        padding: EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4), 
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: _colorPrimary != null ? _colorPrimary : Colors.white,
        ),
        child: Row(
          children: [
            Text(_title!, style: theme.textTheme.button?.copyWith(
              fontSize: 9,
              fontWeight: FontWeight.w600,
              color: _colorPrimary != null ? Colors.white : theme.colorScheme.primary,
            )),
            Container(width: 6),
            _icon!,
          ]
        ),
      )
    );
  }
}