import 'package:flutter/material.dart';

class ButtonLink extends StatelessWidget {
  
  String _title = '';
  String? _type;
  Function()? _func;
  double? _height;
  bool? _isCover;
  AlignmentGeometry? _alignment;
  
  ButtonLink(String title, Function()? func, {String type = 'button', double? height = 50, bool isCover = true, AlignmentGeometry? alignment}) {
    _title = title;
    _type = type;
    _func = func;
    _height = height;
    _isCover = isCover;
    _alignment = alignment;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: _isCover! ? width : null,
      height: _height,
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          padding: EdgeInsets.zero,
          alignment: _alignment ?? null,
        ),
        onPressed: _func,
        child: Text(_title, 
          style: _type == 'button' ? 
            theme.textTheme.button?.copyWith(
              color: theme.colorScheme.primary,
            ) :
            theme.textTheme.bodyText1?.copyWith(
              color: theme.colorScheme.primary,
              decoration: TextDecoration.underline,
            ),
        ),
      ),
    );
  }
}