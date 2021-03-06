import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'GankNewsModel.dart';
import 'package:flutter_app/utils/ScreenUtil.dart';
import 'WebView.dart';
import 'VideoPlay.dart';

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
    print("_GankIoNews=currentType   " + currentType);
    print("_GankIoNews=datas   " + datas.toString());
    return new Scaffold(
        appBar: PreferredSize(
            child: new AppBar(
              title: Text(currentType),
//          ),
              centerTitle: true,
            ),
            preferredSize:
                Size.fromHeight(ScreenUtil.getSysStatsHeight(context) * 1.8)),
        body:
            new RefreshIndicator(child: contentWidget(), onRefresh: _refresh));
  }

  /**
   * 获取数据
   */
  Future<List<GankNewsModel>> _getData(int currentpage, int pageSize) async {
    List lists;
    String url = "http://gank.io/api/data/$currentType/$pageSize/$currentpage";
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

  Future<Null> _loadMoreData() {
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
      case "休息视频":
        return RestVideo(context, datas[index]);
        break;
    }
    return OtherWidget(context, datas[index]);
  }

  Widget RestVideo(BuildContext context, GankNewsModel item) {
    return new Container(
      padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
      width: ScreenUtil.getScreenWidth(context),
      child: Card(
        child: InkWell(
          child: Column(
            children: <Widget>[
              new Container(
                padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                width: ScreenUtil.getScreenWidth(context),
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
                width: ScreenUtil.getScreenWidth(context),
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
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                color: Color.fromARGB(220, 220, 220, 220),
                height: ScreenUtil.getScreenWidth(context)/3,
                child: new Center(
                  child: Image.asset("images/play.png",width: 40,height: 40,),
                ),
              ),
              new Container(
                width: ScreenUtil.getScreenWidth(context),
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
          onTap: () {
            Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) =>
                    new VideoPlay(videoUrl: item.url)));
          },
        ),
      ),
    );
  }

  Widget OtherWidget(BuildContext context, GankNewsModel item) {
    return new Container(
      padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
      width: ScreenUtil.getScreenWidth(context),
      child: new Card(
        child: Column(
          children: <Widget>[
            new Container(
              padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
              width: ScreenUtil.getScreenWidth(context),
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
              width: ScreenUtil.getScreenWidth(context),
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
              padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
              child: new Container(
                child:
                    item.images == null ? null : new gankioImgaes(item.images),
              ),
            ),
            new Container(
              width: ScreenUtil.getScreenWidth(context),
              padding: EdgeInsets.fromLTRB(5, 5, 5, 10),
              child: InkWell(
                child: new Text(
                  item.url,
                  style: new TextStyle(
                    fontSize: 16.0,
                    color: Colors.green,
                  ),
                  textAlign: TextAlign.left,
                ),
                onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) =>
                          new WebView(url: item.url)));
                },
              ),
//              child: new Text(
//                item.url,
//                style: new TextStyle(
//                  fontSize: 16.0,
//                  color: Colors.green,
//                ),
//                textAlign: TextAlign.left,
//              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget fuliWidget(BuildContext context, String url) {
    return new Container(
      color: Colors.white30,
      height: ScreenUtil.getScreenWidth(context) / 3 * 4,
      width: ScreenUtil.getScreenWidth(context),
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

//  interWebview(BuildContext context,String url) {
////    Navigator.of(context).pop();
//    Navigator.of(context).push(new MaterialPageRoute(
//        builder: (BuildContext context) => new WebView(url: url)));
////    Scaffold.of(context).showSnackBar(new SnackBar(content: new Text("nihao")));
//  }
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
        height: getScreenWidth(context) / 2,
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
      height: getScreenWidth(context),
      child: InkWell(
        child: new Container(
          padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
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
