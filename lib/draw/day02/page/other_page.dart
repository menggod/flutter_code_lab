import 'package:flutter/material.dart';

class AcrPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Text("AcrPage"),
      ),
    );
  }
}


class LovePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Text("LovePage"),
      ),
    );
  }
}

class NotePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Text("NotePage"),
      ),
    );
  }

  @override
  StatelessElement createElement() {
    return  super.createElement();
  }
}

class MePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Text("MePage"),
      ),
    );
  }
}