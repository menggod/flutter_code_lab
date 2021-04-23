

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_code_test/view/mask_view.dart';

class CustomViewLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: MaskView(),
    );
  }
}
