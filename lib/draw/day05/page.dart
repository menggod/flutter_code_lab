import 'package:flutter/material.dart';

class TestFull extends StatefulWidget {
  @override
  _TestFullState createState() => _TestFullState();
}

class _TestFullState extends State<TestFull> {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [

        ],
    );
  }
}

_buildText(double value) {
  return Text(
    value.toStringAsFixed(2),//保留两位有效数字
    style: TextStyle(fontSize: 20),
  );
}


class TextSlider extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TextSliderState();
}

class _TextSliderState extends State<TextSlider> {
  double _value = 0;

  @override
  Widget build(BuildContext context) {
    var show = _buildSlider(_value);
    return show;
  }

  _buildSlider(double value) {
    var slider = Slider(
      value: value,
      max: 100,
      min: 0,
      onChanged: (e) {
        print('onChanged:$e');
          print('menggod _buildSlider: ');
        _render(e);
      },
      onChangeStart: (e) {
        print('onChangeStart:$e');
      },
      onChangeEnd: (e) {
        print('onChangeEnd:$e');
      },
    );

    return slider;
  }

  _render(double value) {
    _value = value;
    setState(() {});
  }
}
