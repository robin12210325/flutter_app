import 'package:flutter/material.dart';
import 'mainnews/MainNewsList.dart';
import 'package:flutter_app/PersonCenter.dart';
import 'AddressList.dart';
import 'Map.dart';
import 'DrawerLeft.dart';
import 'package:flutter_app/utils/ScreenUtil.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _MainPageStatus();
  }
}

class _MainPageStatus extends State<MainPage>
    with AutomaticKeepAliveClientMixin {
  String titleKey = "资讯";
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return super.build(context);
//  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  final PageController _pageController = new PageController(initialPage: 0);
  int _tabIndex = 0;

  _onPageChange(int index) {
    setState(() {
      _tabIndex = index;
      if(index == 0){
        titleKey = "资讯";
      }else if(index == 1){
        titleKey = "通讯录";
      }else if(index == 2){
        titleKey = "地图";
      }else if(index == 3){
        titleKey = "个人中心";
      }
    });
  }

  Image _getBarIcon(int index, bool isActive) {
    if (index == 0) {
      return _getAssetIcon(
          isActive ? "images/news_select.png" : "images/news_unselect.png");
    } else if (index == 1) {
      return _getAssetIcon(isActive
          ? "images/addresslist_select.png"
          : "images/addresslist_unselect.png");
    } else if (index == 2) {
      return _getAssetIcon(
          isActive ? "images/map_select.png" : "images/map_unselect.png");
    } else {
      return _getAssetIcon(
          isActive ? "images/person_select.png" : "images/person_unselect.png");
    }
  }

  Image _getAssetIcon(String path) {
    return Image.asset(path, width: 20.0, height: 20.0);
  }

  Text _getBarText(int index) {
    if (index == 0) {
      return Text("资讯", style: TextStyle(color: Colors.black87,));
    } else if (index == 1) {
      return Text("通讯录", style: TextStyle(color: Colors.black87));
    } else if (index == 2) {
      return Text("地图", style: TextStyle(color: Colors.black87));
    } else {
      return Text("个人中心", style: TextStyle(color: Colors.black87));
    }
  }

  @override
  Widget build(BuildContext context) {
    /**
     * 当BottomNavigationBar的type: BottomNavigationBarType.fixed，
     * 背景色由ThemeData.canvasColor决定
     */
    return new MaterialApp(
//      theme: ThemeData(
//          canvasColor: Color(0xffEEEFF2)
//      ),

      home: new Scaffold(
          appBar: PreferredSize(
              child: AppBar(
                title: Text(
                  '$titleKey',
                  style: TextStyle(fontSize: 18.0),
                ),
                backgroundColor: Colors.blue,
                centerTitle: true,
              ),
              preferredSize:
                  Size.fromHeight(ScreenUtil.getSysStatsHeight(context) * 1.8)
          ),
          drawer: new DrawerLeft(),
          body: PageView.builder(
            onPageChanged: _onPageChange,
            controller: _pageController,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return new MainNewsTitleList();
              } else if (index == 1) {
                return new AddressList();
              } else if (index == 2) {
                return new Map();
              } else if (index == 3) {
                return new PersonCenter("");
              }
            },
            itemCount: 4,
          ),
          bottomNavigationBar: new BottomNavigationBar(
            fixedColor: Colors.red,

            type: BottomNavigationBarType.fixed,
            iconSize: 24,
            items: <BottomNavigationBarItem>[
              new BottomNavigationBarItem(
                icon: _getBarIcon(0, false),
                title: _getBarText(0),
                activeIcon: _getBarIcon(0, true),
              ),
              new BottomNavigationBarItem(
                icon: _getBarIcon(1, false),
                title: _getBarText(1),
                activeIcon: _getBarIcon(1, true),
              ),
              new BottomNavigationBarItem(
                icon: _getBarIcon(2, false),
                title: _getBarText(2),
                activeIcon: _getBarIcon(2, true),
              ),
              new BottomNavigationBarItem(
                icon: _getBarIcon(3, false),
                title: _getBarText(3),
                activeIcon: _getBarIcon(3, true),
              ),
            ],
            currentIndex: _tabIndex,
            onTap: (index) {
              _pageController.jumpToPage(index);
//            _pageController.animateToPage(index, duration: Duration(milliseconds: 100), curve: Curves.ease);
              _onPageChange(index);
            },
          )),
    );
  }
}
