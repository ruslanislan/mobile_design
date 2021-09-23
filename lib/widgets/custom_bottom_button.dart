import 'package:RDSH/helper/size_config.dart';
import 'package:RDSH/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class CustomBottomButton extends StatelessWidget {
  const CustomBottomButton({Key? key, this.onTap, required this.text}) : super(key: key);
  final VoidCallback? onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    final dSize = SizeConfig(context);
    return Container(
      height: 88 * dSize.heightRatio,
      width: 375 * dSize.widthRatio,
      child: Column(
        children: [
          Container(
            height: 70 * dSize.heightRatio,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15 * dSize.heightRatio),
                topRight: Radius.circular(
                  15 * dSize.heightRatio,
                ),
              ),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 0),
                  blurRadius: 10,
                  color: Colors.grey.withOpacity(0.5),
                ),
              ],
            ),
            child: Center(
              child: CustomButton(
                key: key,
                text: text,
                onTap: onTap,
              ),
            ),
            // Container(
            //   margin: EdgeInsets.only(
            //     top: 10,
            //     left: 12,
            //     right: 12,
            //     bottom: 10,
            //   ),
            //   width: 352 * dSize.widthRatio,
            //   height: 50 * dSize.heightRatio,
            //   decoration: BoxDecoration(
            //     color: Color(0xFF2858A5),
            //     borderRadius: BorderRadius.circular(
            //       16 * dSize.heightRatio,
            //     ),
            //   ),
            //   child: InkWell(
            //     onTap: onTap,
            //     child: Center(
            //       child: Text(
            //         text,
            //         style: Theme.of(context).primaryTextTheme.headline3!.copyWith(
            //               color: Colors.white,
            //             ),
            //       ),
            //     ),
            //   ),
            // ),
          ),
          Container(
            color: Colors.white,
            height: 18 * dSize.heightRatio,
          ),
        ],
      ),
    );
  }
}
