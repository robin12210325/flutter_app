import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import '../utils/ScreenUtil.dart';
class WebView extends StatefulWidget {
  String url;
  WebView({Key key, this.url}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _WebViewState();
  }
}

class _WebViewState extends State<WebView> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    /* MaterialApp materialApp =  new MaterialApp(
      routes: {
        "/": (_) => new WebviewScaffold(
              url: widget.url,
              appBar: new AppBar(
                title: new Text("webview"),
                centerTitle: true,
                leading: new InkWell(
                  child: Image.asset("images/back.png"),
                  onTap: () {
                    Navigator.of(context).pop(context);
                  },
                ),
              ),
            )

      },
    );*/
    WebviewScaffold scaffold = new WebviewScaffold(
      url: widget.url,
      appBar: PreferredSize(
          child: new AppBar(
            title: new Text("webview"),
            centerTitle: true,
            leading: new InkWell(
              child: Center(
                child: Image.asset(
                  "images/back_white.png",
                  width: 20,
                  height: 20,
                ),
              ),
//          child: Image.asset("images/back_white.png",),
              onTap: () {
                Navigator.of(context).pop(context);
              },
            ),
          ),
          preferredSize:
              Size.fromHeight(ScreenUtil.getSysStatsHeight(context) * 1.8)),
    );
    return WillPopScope(
        child: scaffold,
        onWillPop: () {
          Navigator.pop(context);
          Navigator.of(context).pop();
          Future.value(true);
        });
  }
}
