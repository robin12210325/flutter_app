import 'package:flutter/material.dart';
import 'utils/MessageEvent.dart';
import 'utils/Message.dart';
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
  void initState() {
    // TODO: implement initState
    super.initState();
//    eventBus.fire(new MessageEvent(Message.PERSON_CENTER, "个人中心"));
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: new Center(
        child: new Center(
          child: new Text("个人中心"),
        ),
      ),
    );
  }
}