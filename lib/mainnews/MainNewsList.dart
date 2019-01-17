import 'package:flutter/material.dart';
import '../BaseConstants.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'MainNewsModel.dart';
import 'MainNewsItemTypeList.dart';
import '../DrawerLeft.dart';
import '../utils/MessageEvent.dart';
import '../utils/Message.dart';
import 'package:flutter_app/utils/ScreenUtil.dart';
import 'MainNewsTitles.dart';
import '../utils/SharedPreferencesUtils.dart';

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
    with TickerProviderStateMixin {
  List<NewsTitles> titles = [];
  TabController _controller;
  Dio dio = new Dio();
  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: titles.length, vsync: this);
    if(BaseConstants.items.length>0){
      titles = BaseConstants.items;
    }else{
      _getTitleList();
    }

    eventBus.fire(new MessageEvent(Message.MAIN_NEWS, "资讯"));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller = new TabController(length: titles.length, vsync: this);
    return new Scaffold(
      appBar: /*PreferredSize(
          child:*/ new AppBar(
              backgroundColor: Colors.blue,
              title: new Container(
                child: new TabBar(
                  controller: _controller,
                  tabs: titles.map((item){
                    print("aaaaaaa=" + item.titleText);//NewsTab可以不用声明
                    return new Tab(
                        text: item.titleText);
                  }).toList(),
                  indicatorColor: Colors.white,
                  isScrollable: true,   //水平滚动的开关，开启后Tab标签可自适应宽度并可横向拉动，关闭后每个Tab自动压缩为总长符合屏幕宽度的等宽，默认关闭
                ),
//                height: ScreenUtil.getSysStatsHeight(context)*1.5,
              )
          ),
//          preferredSize:
//          Size.fromHeight(ScreenUtil.getSysStatsHeight(context)*2)
//      ),
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

  Future<Null> _getTitleList() {
    final Completer<Null> completer = new Completer<Null>();
//    Future<List<MainNewsModel>> lsi = _getTitleListData();
//    print("MainNews===8  completer " + lsi.toString());
    _getTitleListData().then((lists) {
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
//        SharedPreferencesUtils.save(titles);
//        SharedPreferencesUtils.read
      BaseConstants.items = titles;
      });
    }).catchError((onerror) {});
    completer.complete(null);
    print("MainNews===3  titleList " + titles.toString());
    return completer.future;
  }
}