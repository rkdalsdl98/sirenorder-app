import 'package:flutter/material.dart';

const int BASE_WIDTH = 360;
const int BASE_HEIGHT = 640;

double getScaleWidth(BuildContext context) {
  final double deviceWidth = MediaQuery.of(context).size.width;
  return deviceWidth / BASE_WIDTH;
}

double getScaleHeight(BuildContext context) {
  final double deviceHeight = MediaQuery.of(context).size.height;
  return deviceHeight / BASE_HEIGHT;
}
