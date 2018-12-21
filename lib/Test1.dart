import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Test extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new TestStates();
  }
}
final themeDataAndroid = new ThemeData(
  primarySwatch: Colors.purple,
  primaryColor: Colors.green[100],
  primaryColorBrightness: Brightness.light
);
final  themeDataIos = new ThemeData(
  primarySwatch: Colors.white,
  primaryColor: Colors.blueGrey,
  primaryColorBrightness: Brightness.light,
);


class TestStates extends State<Test> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      title: "test",
      theme: defaultTargetPlatform == TargetPlatform.android?themeDataAndroid:themeDataIos,
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("test_button"),
          centerTitle: true,
          leading: new Center(
            child: new Text("back"),
            widthFactor: 80.0,
            heightFactor: 100.0,
          ),
        ),
        body: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Center(
              child: new Material(
                child: new InkWell(
                  onTap: null,
                  child: new RaisedButton(
                    onPressed: null,
                    color: Colors.green,
                    child: new Text("点击"),
                  ),
                ),
              ),
            ),
            new Center(
              child: new Material(
                child: new InkWell(
                  onTap: null,
                  child: new RaisedButton(
                    onPressed: null,
                    color: Colors.green,
                    child: new Text("点击1"),
                  ),
                ),
              ),
            ),
            new Center(
              child: new Material(
                child: new Ink(
                  decoration: new BoxDecoration(
                    color: Colors.red,
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(30.0)),
                  ),
                  child: new InkResponse(
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(30.0)),
//                  highlightColor: Colors.yellowAccent,//点击或者toch控件高亮时显示的控件在控件上层,水波纹下层
                    highlightShape: BoxShape.rectangle, //点击或者toch控件高亮的shape形状
                    //.InkResponse内部的radius这个需要注意的是，我们需要半径大于控件的宽，如果radius过小，显示的水波纹就是一个很小的圆，
                    radius: 100.0, //水波纹的半径
                    splashColor: Colors.black, //水波纹的颜色
                    containedInkWell:
                        true, //true表示要剪裁水波纹响应的界面   false不剪裁  如果控件是圆角不剪裁的话水波纹是矩形
                    onTap: () {
                      print(
                          '！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！');
                    },
                    child: new Container(
                      //1.不能在InkResponse的child容器内部设置装饰器颜色，否则会遮盖住水波纹颜色的，containedInkWell设置为false就能看到是否是遮盖了。
                      width: 100.0,
                      height: 50.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
