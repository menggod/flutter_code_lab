import 'dart:html';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(SubEnterState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    margin: EdgeInsets.all(20),
    height: 120,
    color: Colors.black26,
    child: GestureDetector(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Text(
            state.title,
            style: TextStyle(fontSize: 20),
          ))
        ],
      ),
    ),
  );
}
