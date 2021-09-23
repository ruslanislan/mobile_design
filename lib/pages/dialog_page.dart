import 'package:RDSH/helper/size_config.dart';
import 'package:RDSH/pages/add_task_page.dart';
import 'package:RDSH/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DialogPage extends StatelessWidget {
  const DialogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dSize = SizeConfig(context);
    return Scaffold(
      backgroundColor: Color(0xFFE5E5E5),
      body: Center(
        child: Container(
          width: 352 * dSize.widthRatio,
          height: 355 * dSize.heightRatio,
          padding: EdgeInsets.symmetric(vertical: 30 * dSize.heightRatio),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25 * dSize.heightRatio),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(
                  bottom: 5 * dSize.heightRatio,
                ),
                child: SvgPicture.asset(
                  "lib/assets/icons/bg_type.svg",
                  width: 75 * dSize.widthRatio,
                  height: 75 * dSize.heightRatio,
                ),
              ),
              Text(
                "Задание успешно добавлено",
                style: Theme.of(context).primaryTextTheme.headline5,
              ),
              Container(
                width: 300 * dSize.widthRatio,
                height: 40 * dSize.heightRatio,
                child: Text(
                  "Вы можете добавить еще задания, или поделиться проектом",
                  style: Theme.of(context).primaryTextTheme.subtitle1,
                  textAlign: TextAlign.center,
                ),
              ),
              CustomButton(
                key: Key("DialogPageButtonKey"),
                text: 'Перейти к проекту',
                width: 304,
                height: 50,
                onTap: () {},
              ),
              TextButton(
                onPressed: () {
                  index.value = 0;
                  Navigator.pop(context);
                },
                child: Text("Добавить еще задание"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
