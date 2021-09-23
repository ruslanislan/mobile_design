import 'package:RDSH/helper/size_config.dart';
import 'package:RDSH/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomTextField2 extends StatelessWidget {
  const CustomTextField2({
    Key? key,
    required this.text,
    required this.asset,
    this.onTap,
    this.labelText,
  }) : super(key: key);
  final String text;
  final String? labelText;
  final String asset;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final dSize = SizeConfig(context);
    return Container(
      height: 82 * dSize.heightRatio,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RequiredLabelText(text: text),
          SizedBox(
            height: 11 * dSize.heightRatio,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                labelText ?? '',
                style: Theme.of(context).primaryTextTheme.bodyText2!.copyWith(
                      color: Color(0xFF9393AA),
                    ),
              ),
              GestureDetector(
                onTap: onTap,
                child: SvgPicture.asset(asset),
              ),
            ],
          ),
          SizedBox(
            height: 9 * dSize.heightRatio,
          ),
          Divider(thickness: 1,),
          //Container(color: Color(0xFFF1F3F9),height: 2 * dSize.heightRatio,),
        ],
      ),
    );
  }
}
