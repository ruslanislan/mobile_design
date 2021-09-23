import 'package:RDSH/helper/size_config.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  CustomAppBar({
    Key? key,
    this.onPressedBackArrow,
    required this.title,
    this.onPressedCloseButton,
    required this.step,
    required this.current,
  }) : super(key: key);
  final VoidCallback? onPressedBackArrow;
  final String title;
  final VoidCallback? onPressedCloseButton;
  final int step;
  final int current;

  @override
  Widget build(BuildContext context) {
    final dSize = SizeConfig(context);
    return Container(
      height: 64 * dSize.heightRatio,
      width: 375 * dSize.widthRatio,
      child: Stack(
        children: [
          Container(
            color: Colors.white,
            height: 64 * dSize.heightRatio,
            padding: EdgeInsets.symmetric(horizontal: 14 * dSize.widthRatio),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                onPressedBackArrow != null
                    ? IconButton(
                        onPressed: onPressedBackArrow,
                        icon: Icon(
                          Icons.arrow_back,
                          color: Color(0xFF2858A5),
                        ),
                      )
                    : Container(),
                onPressedCloseButton != null
                    ? TextButton(
                        onPressed: onPressedCloseButton,
                        child: Text(
                          "Закрыть",
                          style: Theme.of(context).primaryTextTheme.headline2,
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 14 * dSize.heightRatio),
              child: Column(
                children: [
                  Text(
                    title,
                    style: Theme.of(context).primaryTextTheme.headline1,
                  ),
                  SizedBox(
                    height: 8 * dSize.heightRatio,
                  ),
                  Container(
                    width: 100 * dSize.widthRatio,
                    height: 6 * dSize.heightRatio,
                    decoration: BoxDecoration(
                      color: Color(0xFFF1F3F9),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: 100 / step * current * dSize.widthRatio,
                        height: 6 * dSize.heightRatio,
                        decoration: BoxDecoration(
                          color: Color(0xFF2858A5),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
