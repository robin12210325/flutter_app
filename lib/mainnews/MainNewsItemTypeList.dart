import 'package:flutter/material.dart';
import '../ScreenUtil.dart';
import 'MainNewsModel.dart';
import 'dart:io';
import 'dart:async';
import 'package:dio/dio.dart';
import 'dart:convert';
import '../BaseConstants.dart';
/**
 * 每个分类资讯的列表
 */
class MainNewsItemTypeList extends StatefulWidget {
  String newType;
  MainNewsItemTypeList({Key key, this.newType});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _MainNewsItemTypeList();
  }
}

class _MainNewsItemTypeList extends State<MainNewsItemTypeList>
    with SingleTickerProviderStateMixin {

  List<MainNewsModel> datas;
  int currentPage = 1;
  int pageSize = 10;
  ScrollController _scrollController = new ScrollController();
  Dio dio = new Dio();
  @override
  void initState() {
    super.initState();
    _refresh();
//    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    dio = null;
    _scrollController.dispose();
    datas = null;
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body:
        new RefreshIndicator(child: contentWidget(), onRefresh: _refresh));
  }
  Widget contentWidget() {
    var content;
    if (datas.isEmpty) {
      content = new Center(child: new CircularProgressIndicator());
    } else {
      content = new ListView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: datas.length,
        controller: _scrollController,
        itemBuilder: fuliWidget,
      );
    }
    return content;
  }
  Widget fuliWidget(BuildContext context, int index) {
    return new Container(
      color: Colors.white30,
      height: ScreenUtil.getScreenWidth(context) / 3 * 4,
      width: ScreenUtil.getScreenWidth(context),
      padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0),
      child: InkWell(
        child: Image.network(
          datas[index].icon,
          fit: BoxFit.fill,
        ),
        onTap: null,
      ),
    );
  }
  /**
   * 获取数据
   */
  Future<List<MainNewsModel>> _getData() async {
    List lists;
    String url = BaseConstants.newListItemUrl+widget.newType;
    Response response = await dio.get(url);
    if (response.statusCode == HttpStatus.OK) {
      lists = response.data['results'];
      currentPage += 1;
    }
    return lists.map((model) {
      return MainNewsModel.fromJson(model);
    }).toList();
  }

  /**
   * 进入页面获取第一页数据和下拉刷新
   */
  Future<Null> _refresh() {
    final Completer<Null> completer = new Completer<Null>();
    _getData().then((lists) {
      setState(() {
        datas = lists;
      });
    }).catchError((onerror) {
    });

    completer.complete(null);
    return completer.future;
  }
}