import 'package:flutter/material.dart';
import '../utils/ScreenUtil.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import '../utils/ScreenUtil.dart';
import 'package:flutter/services.dart';
import '../utils/MessageEvent.dart';

class VideoPlay extends StatefulWidget {
  String videoUrl1 =
      "http://baobab.kaiyanapp.com/api/v1/playUrl?vid=146888&resourceType=video&editionType=default&source=aliyun";
  String videoUrl;
  VideoPlay({Key key, this.videoUrl});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _VideoPlay();
  }
}

class _VideoPlay extends State<VideoPlay> with SingleTickerProviderStateMixin {
  VideoPlayerController videoPlayerController;
  bool isPlaying = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
//    eventBus.fire(new MessageEvent("", ""));
  }

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
                Size.fromHeight(ScreenUtil.getSysStatsHeight(context) * 1.8)),
        body:Column(
          children: <Widget>[
            Container(
              height: ScreenUtil.getScreenWidth(context) * 3 / 4,
              child: Center(
                child: new Chewie(
                  new VideoPlayerController.network(this.widget.videoUrl),
                  aspectRatio: 4 / 3,
                  autoPlay: !true,
                  looping: true,
                  showControls: true,
                  fullScreenByDefault: true,
                  // 占位图
                  placeholder: new Container(
                    color: Colors.grey,
                  ),

                  // 是否在 UI 构建的时候就加载视频
                  autoInitialize: !true,

                  // 拖动条样式颜色
                  materialProgressColors: new ChewieProgressColors(
                    playedColor: Colors.red,
                    handleColor: Colors.blue,
                    backgroundColor: Colors.grey,
                    bufferedColor: Colors.lightGreen,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10,20,0,0),
              child: new Text("剧情介绍"),
            )
          ],
        ) ,
      ),
    );
  }
}
