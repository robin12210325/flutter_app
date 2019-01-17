import 'package:flutter/material.dart';
import '../utils/ScreenUtil.dart';
class VideoPlay extends StatefulWidget{
  String videoUrl;
  VideoPlay({Key key,this.videoUrl});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _VideoPlay();
  }
}
class _VideoPlay extends State<VideoPlay> with SingleTickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      home: new Scaffold(
        appBar: PreferredSize(
            child: AppBar(
              title: Text(
                '休息视频',
                style: TextStyle(fontSize: 18.0),
              ),
              backgroundColor: Colors.blue,
              centerTitle: true,
              leading: new InkWell(
                child: Center(
                  child: Image.asset(
                    "images/back_white.png",
                    width: 20,
                    height: 20,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop(context);
                },
              ),
            ),
            preferredSize:
            Size.fromHeight(ScreenUtil.getSysStatsHeight(context) * 1.8)
        ),
        body: Center(
          child: Text("休息视频"),
        ),
      ),
    );
  }
}