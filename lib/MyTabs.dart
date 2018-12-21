import 'package:flutter/material.dart';
class MyTabs extends StatelessWidget{
  final List<Tab> myTabs = <Tab>[
    new Tab(text: '语文'),
    new Tab(text: '数学'),
    new Tab(text: '英语'),
    new Tab(text: '化学'),
    new Tab(text: '物理'),
    new Tab(text: '政治'),
    new Tab(text: '经济'),
    new Tab(text: '体育'),
  ];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new DefaultTabController(
      length: myTabs.length,
      child: new Scaffold(
        appBar: new AppBar(
          bottom: new TabBar(
            tabs: myTabs,
            isScrollable: true,
          ),
        ),
        body: new TabBarView(
          children: myTabs.map((Tab tab) {
            return new Center(child: new Text(tab.text));
          }).toList(),
        ),
      ),
    );
  }
}