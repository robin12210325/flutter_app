import 'package:flutter/material.dart';
import 'dart:async';

import 'HomePage.dart';

class SpashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new SpashPageStates();
  }
}

class SpashPageStates extends State<SpashPage> {
  Timer _t;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _t = new Timer(const Duration(microseconds: 22000), () {
      try {
        Navigator.of(context).pushAndRemoveUntil(
            new MaterialPageRoute(
                builder: (BuildContext context) => new HomePage()),
            (Route route) => route == null);
      } catch (e) {}
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _t.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.tealAccent,
      child: Padding(
          padding: const EdgeInsets.all(100),
          child: new Container(
            child: new Center(
              child: new Text(
                "今日头条",
                textAlign: TextAlign.center,
                style: new TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                ),
              ),
            ),
          )),
    );
  }
}
