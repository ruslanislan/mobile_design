import 'package:flutter/material.dart';

class RequiredLabelText extends StatelessWidget {
  const RequiredLabelText({Key? key, required this.text, this.requiredText = true}) : super(key: key);
  final String text;
  final bool requiredText;
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text,
            style: Theme
                .of(context)
                .primaryTextTheme
                .headline2!
                .copyWith(
              color: Color(0xFF9393AA),
            ),
          ),
          if(requiredText)
          TextSpan(
            text: "*",
            style: Theme
                .of(context)
                .primaryTextTheme
                .headline2!
                .copyWith(
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
