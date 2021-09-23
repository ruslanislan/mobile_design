import 'package:RDSH/helper/size_config.dart';
import 'package:RDSH/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dSize = SizeConfig(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12 * dSize.widthRatio),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 26 * dSize.heightRatio,
            ),
            Container(
              height: 278 * dSize.heightRatio,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RequiredLabelText(text: "Изображение"),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF1F3F9),
                      borderRadius: BorderRadius.circular(12 * dSize.heightRatio),
                    ),
                    height: 204 * dSize.heightRatio,
                    margin: EdgeInsets.symmetric(vertical: 16 * dSize.heightRatio),
                    child: Center(
                      child: GestureDetector(
                        onTap: () {},
                        child: SvgPicture.asset(
                          "lib/assets/icons/add_button.svg",
                          width: 42 * dSize.widthRatio,
                          height: 42 * dSize.heightRatio,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "Рекомендуем загрузить файл с соотношением сторон 3:2",
                    style: Theme.of(context).primaryTextTheme.headline2!.copyWith(
                          color: Color(0xFF9393AA),
                        ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10 * dSize.heightRatio,
            ),
            CustomTextField(text: "Описание задания"),
            SizedBox(
              height: 12 * dSize.heightRatio,
            ),
            CustomTextField2(
              text: "Выбор способа отчета задания",
              asset: "lib/assets/icons/profile_arrow.svg",
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
