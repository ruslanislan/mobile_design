import 'package:RDSH/constants/route_consts.dart';
import 'package:RDSH/helper/size_config.dart';
import 'package:RDSH/pages/add_task/screen_builder.dart';
import 'package:RDSH/widgets/widgets.dart';
import 'package:flutter/material.dart';

ValueNotifier<int> index = ValueNotifier(0);

class AddTaskPage extends StatelessWidget {
  AddTaskPage({Key? key}) : super(key: key);
  List<String> appBarTitles = [
    "Добавление задания",
    "Изображение, описание  и способ отчета",
    "Вспомогательные материалы",
  ];
  List<String> bottomButtonTitles = [
    "Продолжить",
    "Продолжить",
    "Добавить задание",
  ];

  @override
  Widget build(BuildContext context) {
    final dSize = SizeConfig(context);
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: index,
        builder: (BuildContext context, int value, Widget? child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    height: 20 * dSize.heightRatio,
                    color: Colors.white,
                  ),
                  CustomAppBar(
                    title: appBarTitles[value],
                    onPressedBackArrow: value != 0
                        ? () {
                            index.value = index.value - 1;
                          }
                        : null,
                    onPressedCloseButton: value == 0 ? () {} : null,
                    current: value + 1,
                    step: 3,
                  ),
                ],
              ),
              Expanded(
                child: ScreenBuilder(value: value),
              ),
              CustomBottomButton(
                key: Key("AddTaskPageButton"),
                onTap: () {
                  if (index.value < 2)
                    index.value = index.value + 1;
                  else
                    Navigator.pushNamed(context, DIALOG_PAGE);
                },
                text: bottomButtonTitles[value],
              ),
            ],
          );
        },
      ),
    );
  }
}
