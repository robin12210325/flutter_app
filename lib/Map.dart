import 'package:flutter/material.dart';
class Map extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _Map();
  }
}
class _Map extends State<Map> with SingleTickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Text("nihao"),
      ),
    );
  }
}