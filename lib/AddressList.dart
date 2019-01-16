import 'package:flutter/material.dart';
import 'utils/Message.dart';
import 'utils/MessageEvent.dart';

class AddressList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _AddressList();
  }
}

class _AddressList extends State<AddressList> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    eventBus.fire(new MessageEvent(Message.ADDRESS_LIST, "通讯录"));
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: new Center(
          child: new Center(
            child: new Text("通讯录"),
          )
      ),
    );
  }
}
