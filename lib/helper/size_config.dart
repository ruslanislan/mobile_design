import 'package:RDSH/constants/constants.dart';
import 'package:flutter/material.dart';

class SizeConfig {
  late final double heightRatio;
  late final double widthRatio;

  SizeConfig(BuildContext context){
    heightRatio = MediaQuery.of(context).size.height / layoutHeight;
    widthRatio = MediaQuery.of(context).size.width / layoutWidth;
  }
}