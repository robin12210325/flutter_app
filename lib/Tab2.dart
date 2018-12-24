import 'package:flutter/material.dart';

class Tab2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _Tab2();
  }
}

class _Tab2 extends State<Tab2> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: null,
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text(
          "通讯录",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: new Center(
          child: new Center(
            child: new Text("通讯录"),
          )
      ),
    );
  }
}
