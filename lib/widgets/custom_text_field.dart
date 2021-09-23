import 'package:RDSH/helper/size_config.dart';
import 'package:RDSH/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({Key? key, required this.text, this.requiredText = true}) : super(key: key);
  final String text;
  final bool requiredText;
  @override
  Widget build(BuildContext context) {
    final dSize = SizeConfig(context);
    return Container(
      height: 82 * dSize.heightRatio,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RequiredLabelText(text: text, requiredText: requiredText,),
          TextField(),
        ],
      ),
    );
  }
}
