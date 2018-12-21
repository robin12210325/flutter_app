import 'package:flutter/material.dart';
import 'PersonCenter.dart';
import 'GankIoNews.dart';

class DrawerLeft extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _DrewerLeftStatus();
  }
}

class _DrewerLeftStatus extends State<DrawerLeft> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("yongxing"),
            accountEmail: Text("yongxingg1221@gmail.com"),
            currentAccountPicture: new GestureDetector(
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://upload.jianshu.io/users/upload_avatars/7700793/dbcf94ba-9e63-4fcf-aa77-361644dd5a87?imageMogr2/auto-orient/strip|imageView2/1/w/240/h/240"),
              ),
              onTap: () => print("other User"),
            ),
            otherAccountsPictures: <Widget>[
              new GestureDetector(
                //手势探测器，可以识别各种手势，这里只用到了onTap
                onTap: () => print('other user'), //暂且先打印一下信息吧，以后再添加跳转页面的逻辑
                child: new CircleAvatar(
                  backgroundImage: new NetworkImage(
                      'https://upload.jianshu.io/users/upload_avatars/10878817/240ab127-e41b-496b-80d6-fc6c0c99f291?imageMogr2/auto-orient/strip|imageView2/1/w/240/h/240'),
                ),
              ),
              new GestureDetector(
                onTap: () => print('other user'),
                child: new CircleAvatar(
                  backgroundImage: new NetworkImage(
                      'https://upload.jianshu.io/users/upload_avatars/8346438/e3e45f12-b3c2-45a1-95ac-a608fa3b8960?imageMogr2/auto-orient/strip|imageView2/1/w/240/h/240'),
                ),
              ),
            ],
          ),
          ListTile(
            title: new Text("全部"),
            trailing: new Icon(Icons.arrow_right),
            onTap: () {
              Scaffold.of(context)
                  .showSnackBar(new SnackBar(content: new Text("ashkaha")));
              Navigator.of(context).pop();
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new PersonCenter("all")));
            },
          ),
          new Divider(),
          ListTile(
            title: new Text("android"),
            trailing: new Icon(Icons.arrow_right),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) =>
                      new GankIoNews("Android")));
            },
          ),
          ListTile(
            title: new Text("IOS"),
            trailing: new Icon(Icons.arrow_right),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) =>
                  new GankIoNews("iOS")));
            },
          ),
          ListTile(
            title: new Text("休息视频"),
            trailing: new Icon(Icons.arrow_right),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) =>
                      new GankIoNews("休息视频")));
            },
          ),
          ListTile(
            title: new Text("扩展资源"),
            trailing: new Icon(Icons.arrow_right),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) =>
                      new GankIoNews("拓展资源")));
            },
          ),
          ListTile(
            title: new Text("前端"),
            trailing: new Icon(Icons.arrow_right),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) =>
                      new GankIoNews("前端 ")));
            },
          ),
          ListTile(
            title: new Text("福利"),
            trailing: new Icon(Icons.arrow_right),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new GankIoNews("福利")));
            },
          )
        ],
      ),
    );
  }
}
