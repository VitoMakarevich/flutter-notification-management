import 'package:flutter/material.dart';

class CommonCard extends StatelessWidget{
  Widget child;

  CommonCard({this.child, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: this.child,
      ),
    );
  }
}