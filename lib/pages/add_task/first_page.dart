import 'package:RDSH/helper/size_config.dart';
import 'package:RDSH/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dSize = SizeConfig(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 26 * dSize.heightRatio,
            ),
            Container(
              padding: EdgeInsets.only(
                left: 20 * dSize.widthRatio,
                right: 20 * dSize.widthRatio,
                bottom: 12 * dSize.heightRatio,
              ),
              height: 198 * dSize.heightRatio,
              decoration: BoxDecoration(
                color: Color(0xFFF1F3F9),
              ),
              child: Stack(
                children: [
                  Container(
                    height: 154 * dSize.heightRatio,
                    color: Color(0xFFF1F3F9),
                  ),
                  Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 335 * dSize.widthRatio,
                            height: 136 * dSize.heightRatio,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                12 * dSize.heightRatio,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                12 * dSize.heightRatio,
                              ),
                              child: Image.asset(
                                "lib/assets/images/image1.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 15 * dSize.widthRatio,
                            bottom: 18 * dSize.heightRatio,
                            child: Container(
                              width: 232 * dSize.widthRatio,
                              height: 30 * dSize.heightRatio,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 118 * dSize.widthRatio,
                                    height: 30 * dSize.heightRatio,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF717988).withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(
                                        14 * dSize.heightRatio,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "29.10.20–18.01.21",
                                        style: Theme.of(context).primaryTextTheme.overline,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 52 * dSize.widthRatio,
                                    height: 30 * dSize.heightRatio,
                                    padding: EdgeInsets.symmetric(horizontal: 9 * dSize.widthRatio),
                                    decoration: BoxDecoration(
                                      color: Color(0xFF717988).withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(
                                        14 * dSize.heightRatio,
                                      ),
                                    ),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          SvgPicture.asset(
                                            "lib/assets/icons/community.svg",
                                          ),
                                          Text(
                                            "25",
                                            style: Theme.of(context).primaryTextTheme.overline,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 56 * dSize.widthRatio,
                                    height: 30 * dSize.heightRatio,
                                    padding: EdgeInsets.symmetric(horizontal: 9 * dSize.widthRatio),
                                    decoration: BoxDecoration(
                                      color: Color(0xFF717988).withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(
                                        14 * dSize.heightRatio,
                                      ),
                                    ),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          SvgPicture.asset(
                                            "lib/assets/icons/light.svg",
                                          ),
                                          Text(
                                            "231",
                                            style: Theme.of(context).primaryTextTheme.overline,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10 * dSize.heightRatio,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: 280 * dSize.widthRatio,
                          height: 40 * dSize.heightRatio,
                          child: Text(
                            "Всероссийская киберспортивная школьная лига",
                            style: Theme.of(context).primaryTextTheme.headline3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30 * dSize.heightRatio,
            ),
            Container(
              height: 270 * dSize.heightRatio,
              padding: EdgeInsets.symmetric(horizontal: 12 * dSize.widthRatio),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTextField(text: "Название задания"),
                  CustomTextField2(
                    text: "Даты проведения",
                    asset: 'lib/assets/icons/calendar.svg',
                    labelText: "ДД . ММ . ГГ   —  ДД . ММ . ГГ",
                    onTap: (){},
                  ),
                  CustomTextField(text: "Количество баллов"),
                ],
              ),
            ),
            SizedBox(
              height: 92 * dSize.heightRatio,
            ),
          ],
        ),
      ),
    );
  }
}
