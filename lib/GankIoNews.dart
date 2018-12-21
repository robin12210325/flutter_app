import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'GankNewsModel.dart';

class GankIoNews extends StatefulWidget {
  final String type;
  GankIoNews(this.type);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _GankIoNews(type);
  }
}

class _GankIoNews extends State<GankIoNews>
    with SingleTickerProviderStateMixin {
  String currentType;
  _GankIoNews(this.currentType);
  List<GankNewsModel> datas = [];
  int currentPage = 1;
  int pageSize = 10;
  ScrollController _scrollController = new ScrollController();
  Dio dio = new Dio();
  @override
  void initState() {
    super.initState();
    _refresh();
    _scrollController.addListener(_scrollListener);
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
    // TODO: implement build
    print("_GankIoNews=currentType   " + currentType);
    print("_GankIoNews=datas   " + datas.toString());
    return new Scaffold(
        appBar: new AppBar(
          title: new Center(
            child: Text(currentType),
          ),
          centerTitle: true,
        ),
        body:
            new RefreshIndicator(child: contentWidget(), onRefresh: _refresh));
  }

  /**
   * 获取数据
   */
  Future<List<GankNewsModel>> _getData(int currentPage, int pageSize) async {
    List lists;
    String url = "http://gank.io/api/data/$currentType/$pageSize/$currentPage";
    print("_GankIoNews=url   " + currentType);
    Response response = await dio.get(url);
    if (response.statusCode == HttpStatus.OK) {
      lists = response.data['results'];
      currentPage += 1;
    }
    return lists.map((model) {
      return GankNewsModel.fromJson(model);
    }).toList();
  }

  /**
   * 进入页面获取第一页数据和下拉刷新
   */
  Future<Null> _refresh() {
    final Completer<Null> completer = new Completer<Null>();
    currentPage = 1;
    datas.clear();
    _getData(currentPage, pageSize).then((lists) {
      setState(() {
        datas = lists;
        print("_GankIoNews=lists   " + lists.toString());
      });
    }).catchError((onerror) {
      print("_GankIoNews=onerror   " + onerror);
    });

    completer.complete(null);
    return completer.future;
  }
  Future<Null> _loadMoreData(){
    final Completer<Null> completer = new Completer<Null>();
    _getData(currentPage, pageSize).then((lists) {
      setState(() {
//        datas = lists;
        datas.addAll(lists);
        print("_GankIoNews=_loadMoreData   " + datas.toString());
      });
    }).catchError((onerror) {
      print("_GankIoNews=_loadMoreDataonerror   " + onerror);
    });

    completer.complete(null);
    return completer.future;
  }

  //滑动到底了自动加载更多
  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadMoreData();
    }
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
        itemBuilder: buildCardItem,
      );
    }
    return content;
  }

  Widget buildCardItem(BuildContext context, int index) {
    switch (currentType) {
      case "福利":
        return fuliWidget(context, datas[index].url);
        break;
    }
    return OtherWidget(context, datas[index]);
  }

  Widget OtherWidget(BuildContext context, GankNewsModel item) {
    return new Container(
      padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
      width: getScreenWidth(context),
      child: new Card(
        child: Column(
          children: <Widget>[
            new Container(
              padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
              width: getScreenWidth(context),
              child: new Text(
                item.publishedAt,
                style: new TextStyle(
                  fontSize: 14.0,
                  color: Colors.deepOrange,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            new Container(
              padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
              width: getScreenWidth(context),
              child: new Text(
                item.desc,
                style: new TextStyle(
                  fontSize: 14.0,
                  color: Colors.deepOrange,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            new Container(
              child: new Container(
                child: item.images == null
                    ? new Text("")
                    : new gankioImgaes(item.images),
              ),
            ),
            new Container(
              width: getScreenWidth(context),
              padding: EdgeInsets.fromLTRB(5, 5, 5, 10),
              child: new Text(
                item.url,
                style: new TextStyle(
                  fontSize: 16.0,
                  color: Colors.green,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget fuliWidget(BuildContext context, String url) {
    return new Container(
      color: Colors.white30,
      height: getScreenWidth(context) / 3 * 4,
      width: getScreenWidth(context),
      padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0),
      child: InkWell(
        child: Image.network(
          url,
          fit: BoxFit.fill,
        ),
        onTap: null,
      ),
    );
  }

  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  /** 获取屏幕高度 */
  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  /** 获取系统状态栏高度 */
  static double getSysStatsHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }
}

class gankioImgaes extends StatefulWidget {
  List images;
  gankioImgaes(this.images);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    print("_GankIoNews=images   " + images.toString());
    return new _Images(images);
  }
}

class _Images extends State<gankioImgaes> {
  List currentImages;
  _Images(this.currentImages);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
//    return new ListView.builder(
//      itemCount: currentImages.length,
//        itemBuilder: imageWidget,
//    );
    return Container(
        height: getScreenWidth(context) / 3,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: currentImages.length,
          itemBuilder: imageWidget,
        ));
  }

  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  Widget imageWidget(BuildContext context, int index) {
    return new Container(
      color: Colors.white30,
      height: getScreenWidth(context) / 3,
      child: InkWell(
        child: new Container(
          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
          child: Image.network(
            currentImages[index],
            fit: BoxFit.fill,
          ),
        ),
        onTap: null,
      ),
    );
  }
}
