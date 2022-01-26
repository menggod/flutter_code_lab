import 'package:flutter/material.dart';
import 'package:flutter_code_test/utils/color_utils.dart';
import 'package:flutter_code_test/view/square_grid_view.dart';
import 'package:get/get.dart';

import 'effect.dart';
import 'widget/poem_item_view.dart';

class HomeListPage extends StatelessWidget {
  final effect = Get.put(HomeListEffect());
  final state = Get.find<HomeListEffect>().state;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          SquareGridView(displayAxis: false),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              margin: EdgeInsets.only(right: 200),
              child: Text(
                'menggod',
                style: TextStyle(
                    decoration: TextDecoration.none,
                    color: ColorGenerator().getRandomColor(),
                    fontSize: 18),
              ),
            ),
          ),
          SafeArea(
            child: _buildRealContainer(),
          ),
        ],
      ),
    );
  }

  Widget _buildRealContainer() {
    return Container(
        child: ListView.builder(
            itemCount: state.data.length,
            itemBuilder: (BuildContext context, int index) {
              return PoemItemView(
                state.data[index],
              );
            }));
  }
}
