import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}


Color randomRGB() {
  Random random = new Random();
  int r = 30 + random.nextInt(200);
  int g = 30 + random.nextInt(200);
  int b = 30 + random.nextInt(200);
  return Color.fromARGB(255, r, g, b);
}

Color randomARGB() {
  Random random = new Random();
  int r = 30 + random.nextInt(200);
  int g = 30 + random.nextInt(200);
  int b = 30 + random.nextInt(200);
  int a = 50 + random.nextInt(150);
  return Color.fromARGB(a, r, g, b);
}

class ColorGenerator {
  static const defaultList = [
    0xfff16364,
    0xfff58559,
    0xfff9a43e,
    0xffe4c62e,
    0xff67bf74,
    0xff59a2be,
    0xff2093cd,
    0xffad62a7,
    0xff805781
  ];

  static const materialList = [
    0xffe57373,
    0xfff06292,
    0xffba68c8,
    0xff9575cd,
    0xff7986cb,
    0xff64b5f6,
    0xff4fc3f7,
    0xff4dd0e1,
    0xff4db6ac,
    0xff81c784,
    0xffaed581,
    0xffff8a65,
    0xffd4e157,
    0xffffd54f,
    0xffffb74d,
    0xffa1887f,
    0xff90a4ae
  ];

  List<int> mColors;
  Random mRandom;

  static ColorGenerator create(List<int> colorList) {
    return ColorGenerator();
  }

  ColorGenerator({List<int> colorList = materialList}) {
    mColors = colorList;
    mRandom = Random(DateTime.now().millisecondsSinceEpoch);
  }

  Color getColor(Object key) => Color(mColors[key.hashCode.abs() % mColors.length]);

  Color getRandomColor() {
    return Color(mColors[mRandom.nextInt(mColors.length)]);
  }
}
