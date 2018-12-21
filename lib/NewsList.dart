import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'GankNewsModel.dart';


class NewsList extends StatefulWidget {
  // ignore: final_not_initialized
  final String newsType;

  const NewsList({Key key, this.newsType}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _NewsListStatus();
  }
}

class _NewsListStatus extends State<NewsList>
    with SingleTickerProviderStateMixin {
  List<GankNewsModel> datas = [];
  int currentpage = 1;
  int pageSize = 10;
  Dio dio = new Dio();
  ScrollController _scrollController;

  //滑动到底了自动加载更多
  void _scrollListener(){
    if(_scrollController.position.pixels==_scrollController.position.maxScrollExtent){
      _loadMoreData();
    }
  }

//页面初始化时加载数据并实例化ScrollController
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshData();
    _scrollController = new ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.removeListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    var content ;
    if(datas.isEmpty){
      content =  new Center(child: new CircularProgressIndicator());;
    }else{
      content = new ListView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: datas.length,
        controller: _scrollController,
        itemBuilder: buildCardItem,
      );
    }

    var _refreshIndicator = new RefreshIndicator(
      onRefresh: _refreshData,
      child: content,
    );
    return _refreshIndicator;
  }
//  void _showPhoto(String url) {
//    Navigator.of(context).push(new PageRouteBuilder(
//        opaque: false,
//        pageBuilder: (BuildContext context, _, __) {
//          return new MultiTouchPage(url);
//        },
//        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
//          return new FadeTransition(
//            opacity: animation,
//            child: new RotationTransition(
//              turns: new Tween<double>(begin: 0.5, end: 1.0).animate(animation),
//              child: child,
//            ),
//          );
//        }));
//  }

  Widget buildCardItem(BuildContext context,int index){
    final String url = datas[index].url;
    //print("android===3 " + datas[index].images.toString());
    GankNewsModel item = datas[index];
    print("android===4 " + item.images.toString());
    if(item.images != null){
      print("android===5 " + item.images[0]);
      return new GestureDetector(//点击事件
        onTap: (){

//        _showPhoto(url);
        },
        child: new Card(
          child: new Container(
              padding: EdgeInsets.all(8.0),
          child: new Image.network(item.images[0]),
//              child: new Column(
//                children: <Widget>[
//                  new Container(
//                    child: new Text(item.desc,
//                      textAlign: TextAlign.left,
//                      overflow: TextOverflow.ellipsis,
//                      style: new TextStyle(
//                        color: Colors.tealAccent,
//                        fontSize: 16.0,
//                      ),
//                    ),
//                  )
//                ],
//              )
          ),
        ),
      );
    }else{
      return new GestureDetector(//点击事件
        onTap: (){

//        _showPhoto(url);
        },
        child: new Card(
          child: new Container(
              padding: EdgeInsets.all(8.0),
//          child: new Image.network(url),
              child: new Column(
                children: <Widget>[
                  new Container(
                    child: new Text(item.desc,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style: new TextStyle(
                        color: Colors.tealAccent,
                        fontSize: 16.0,
                      ),
                    ),
                  )
                ],
              )
          ),
        ),
      );
    }

  }

  //刷新时调用
  Future<Null> _refreshData(){
    final Completer<Null> completer = new Completer<Null>();
    currentpage = 1;
    datas.clear();
    feach(currentpage, pageSize).then((list) {
      setState(() {
        datas = list;
        print("android====1" + datas.toString());
      });
    }).catchError((error) {
      print(error);
    });
    completer.complete(null);
    return completer.future;
  }

  //加载更多时调用
  Future<Null> _loadMoreData(){

    final Completer<Null> completer = new Completer<Null>();


    feach(currentpage, pageSize).then((list) {
      setState(() {
        datas.addAll(list);
      });
    }).catchError((error) {
      print(error);
    });
    completer.complete(null);

    return completer.future;
  }

  Future<List<GankNewsModel>> feach(int pageNum,int pageSize){
    return _getDate(pageNum, pageSize);
  }

  Future<List<GankNewsModel>>  _getDate(int pageNum,int pageSize) async{
    List flModels;
    String url = 'http://gank.io/api/data/Android/$pageSize/$pageNum';
    print(url);
    Response response = await dio.get(url);
    if(response.statusCode== HttpStatus.OK){//响应成功
      flModels = (response.data)['results'] ;
      currentpage = currentpage+1;//加载成功后才可加载下一页
    }else{//出问题
    }
    print("android====2" + flModels.toString());
    print(flModels.map((model) {
      return new GankNewsModel.fromJson(model);
    }).toList().length);

    return flModels.map((model) {
      return new GankNewsModel.fromJson(model);
    }).toList();

  }
}
