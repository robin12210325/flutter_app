import 'package:flutter/material.dart';
import '../BaseConstants.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'MainNewsModel.dart';
import 'MainNewsItemTypeList.dart';

class NewsTitles {
  String titleText;
  MainNewsItemTypeList newsItemTypeList;
  NewsTitles(this.titleText, this.newsItemTypeList);
}

/**
 * 资讯的分类
 */
class MainNewsTitleList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _MainNewsTitleList();
  }
}

class _MainNewsTitleList extends State<MainNewsTitleList>
    with SingleTickerProviderStateMixin {
//  List<NewsTitles> titles = [];

  final List<NewsTitles> titles = <NewsTitles>[
    new NewsTitles('科技资讯',new MainNewsItemTypeList(newType: 'wow')),    //拼音就是参数值
    new NewsTitles('趣味软件/游戏',new MainNewsItemTypeList(newType: 'apps')),
    new NewsTitles('装备党',new MainNewsItemTypeList(newType: 'imrich')),
    new NewsTitles('草根新闻',new MainNewsItemTypeList(newType: 'funny')),
    new NewsTitles('Android',new MainNewsItemTypeList(newType: 'android')),
    new NewsTitles('创业新闻',new MainNewsItemTypeList(newType: 'diediedie')),
    new NewsTitles('独立思想',new MainNewsItemTypeList(newType: 'thinking')),
    new NewsTitles('iOS',new MainNewsItemTypeList(newType: 'iOS')),
    new NewsTitles('团队博客',new MainNewsItemTypeList(newType: 'teamblog')),
  ];
  TabController _controller;
  Dio dio = new Dio();
  @override
  void initState() {
    _controller = new TabController(length: titles.length, vsync: this);
//    _getTitleList();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.blue,
        title: new Container(
          child: new TabBar(
            controller: _controller,
            tabs: titles.map((item){      //NewsTab可以不用声明
              return new Tab(
                  text: item.titleText);
            }).toList(),
            indicatorColor: Colors.white,
            isScrollable: true,   //水平滚动的开关，开启后Tab标签可自适应宽度并可横向拉动，关闭后每个Tab自动压缩为总长符合屏幕宽度的等宽，默认关闭
          ),
        )
      ),
      body: TabBarView(
        controller: _controller,
        children: titles.map((item) {
          return item.newsItemTypeList; //使用参数值
        }).toList(),
      ),
    );
  }

  Future<List<MainNewsModel>> _getTitleListData() async {
    String url = BaseConstants.newTitleListUrl;
    List datas;
    Response response = await dio.get(url);
    if (response.statusCode == HttpStatus.OK) {
      datas = response.data['results'];
      print("MainNews===2  titleList " + datas.toString());
      return datas.map((models) {
        return MainNewsModel.fromJson(models);
      }).toList();
    }
  }

  List<MainNewsModel> _getTitleListData1()  {
    String url = BaseConstants.newTitleListUrl;
    List datas;
    Response response = await h.get(url);
    if (response.statusCode == HttpStatus.OK) {
      datas = response.data['results'];
      print("MainNews===2  titleList " + datas.toString());
      return datas.map((models) {
        return MainNewsModel.fromJson(models);
      }).toList();
    }
  }

  Future<Null> _getTitleList() {
    final Completer<Null> completer = new Completer<Null>();

    Future<List<MainNewsModel>> lsi = _getTitleListData();
    print("MainNews===8  completer " + lsi.toString());
    lsi.then((lists) {
      //setState和adapter中的notifySetdataChanged类似
      print("MainNews===8  completer " + lists.toString());
      setState(() {
        NewsTitles newsTitles;
        titles.clear();
        for (int i = 0; i < lists.length; i++) {
          newsTitles = new NewsTitles(lists[i].name,
              new MainNewsItemTypeList(newType: lists[i].en_name));
          titles.add(newsTitles);
          print("MainNews===3  titleList " + newsTitles.toString());
        }
      });
    }).catchError((onerror) {});
    completer.complete(null);
    print("MainNews===3  titleList " + titles.toString());
    return completer.future;
  }
}