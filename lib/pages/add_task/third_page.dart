import 'package:RDSH/helper/size_config.dart';
import 'package:RDSH/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ThirdPage extends StatelessWidget {
  const ThirdPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dSize = SizeConfig(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12 * dSize.widthRatio,),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 26 * dSize.heightRatio,
            ),
            CustomTextField(
              text: "Вставьте ссылку",
              requiredText: false,
            ),
            SizedBox(
              height: 20 * dSize.heightRatio,
            ),
            Container(
              height: 50 * dSize.heightRatio,
              child: GestureDetector(
                onTap: () {},
                child: Center(
                  child: Text(
                    "Добавить файлы",
                    style: Theme.of(context).primaryTextTheme.headline4!.copyWith(
                          color: Color(0xFF2858A5),
                        ),
                  ),
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Color(0xFF2858A5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
