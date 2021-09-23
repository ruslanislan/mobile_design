import 'package:RDSH/constants/route_consts.dart';
import 'package:RDSH/pages/add_task/first_page.dart';
import 'package:RDSH/pages/add_task/second_page.dart';
import 'package:RDSH/pages/add_task/third_page.dart';
import 'package:flutter/material.dart';

class ScreenBuilder extends StatelessWidget {
  const ScreenBuilder({Key? key, required this.value}) : super(key: key);
  final int value;

  @override
  Widget build(BuildContext context) {
    if (value == 0) return FirstPage();
    if (value == 1) return SecondPage();
    if (value == 2) return ThirdPage();
    return Container();
  }
}
