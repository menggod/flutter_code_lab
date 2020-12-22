import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'state.dart';

Widget buildView(ItemState state, Dispatch dispatch, ViewService viewService) {
  return _bodyWidget(state);
}

Widget _bodyWidget(ItemState state) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    elevation: 5,
    margin: EdgeInsets.all(10),
    child: Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(10),
          width: 180,
          height: 100,
          child: Image.network(
            state.itemDetail.envelopePic,
            fit: BoxFit.fill,
          ),
        ),
        _rightContent(state)
      ],
    ),
  );
}

Widget _rightContent(ItemState state) {
  return Expanded(
    child: Container(
      margin: EdgeInsets.all(10),
      height: 120,
      child: Column(
        children: <Widget>[
          
        ],
      ),
    ),
  );
}
