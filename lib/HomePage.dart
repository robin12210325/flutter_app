import 'package:flutter/material.dart';
import 'Mine.dart';
import 'PersonCenter.dart';
import 'Tab2.dart';
import 'Tab3.dart';
import 'DrawerLeft.dart';
import 'NewsList.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _HomePage();
  }
}

class _HomePage extends State<HomePage> with SingleTickerProviderStateMixin {
  TabController _controller;
  final List<Tab> list = <Tab>[
    new Tab(
      text: 'Home',
      icon: new Icon(Icons.home),
    ), //icon和text的显示顺序已经内定，如需自定义，到child属性里面加吧
    new Tab(
      icon: new Icon(Icons.history),
      text: 'History',
    ),
    new Tab(
      icon: new Icon(Icons.book),
      text: 'Book',
    ),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = new TabController(length: list.length, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: Text("yongxing"),
        backgroundColor: Colors.blue,
      ),
      drawer: new DrawerLeft(),
      body: TabBarView(
        children: [new NewsList(), new Tab2(), new Tab3()],
        controller: _controller,
      ),
      bottomNavigationBar: new Container(
        height: 60.0,
        child: new Material(
          color: Colors.blue,
          child: TabBar(
            tabs: list,
            controller: _controller,
            indicatorColor: Colors.blue,
          ),
        ),
      ),
    );
  }
}
