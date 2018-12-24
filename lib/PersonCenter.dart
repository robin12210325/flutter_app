import 'package:flutter/material.dart';
class PersonCenter extends StatefulWidget{
  final String titleStr;
  PersonCenter(this.titleStr);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _PersonCenter(titleStr);
  }
}
class _PersonCenter extends State<PersonCenter> {
  final String titleStrState;
  _PersonCenter(this.titleStrState);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: null,
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text("个人中心",style: TextStyle(color: Colors.white),),
      ),
      body: new Center(
        child: new Center(
          child: new Text("个人中心"),
        ),
      ),
    );
  }
}