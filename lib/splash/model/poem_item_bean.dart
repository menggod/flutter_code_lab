import 'dart:ui';

import 'package:flutter_code_test/utils/color_utils.dart';

class PoemItem {
  late Color image;
  String? title; //标题
  String? author; //作者
  String? summary; //摘要
  PoemItem({this.title, this.author = "menggod", this.summary}) {
    image = ColorGenerator.create(ColorGenerator.materialList).getColor(title!);
  }
}
