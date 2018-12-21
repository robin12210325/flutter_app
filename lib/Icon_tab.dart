import 'package:flutter/material.dart';
const double tabHeight = 50.0;
const double divideIconAndText = 5.0;
class ICon_Tab extends StatefulWidget{
  String text;
  String icon;
  Color color;
  ICon_Tab(this.text,this.icon,this.color);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new IconTabStatus();
  }
}
class IconTabStatus extends State<ICon_Tab> with SingleTickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}