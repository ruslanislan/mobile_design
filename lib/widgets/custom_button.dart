import 'package:RDSH/helper/size_config.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({Key? key, this.width = 352, this.height = 50, required this.text, this.onTap}) : super(key: key);
  final double? width;
  final double? height;
  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final dSize = SizeConfig(context);
    return Container(
      width: width! * dSize.widthRatio,
      height: height! * dSize.heightRatio,
      decoration: BoxDecoration(
        color: Color(0xFF2858A5),
        borderRadius: BorderRadius.circular(
          16 * dSize.heightRatio,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Text(
            text,
            style: Theme.of(context).primaryTextTheme.headline3!.copyWith(
                  color: Colors.white,
                ),
          ),
        ),
      ),
    );
  }
}
