import 'package:shared_preferences/shared_preferences.dart';
import '../mainnews/MainNewsTitles.dart';
import 'dart:convert';

class SharedPreferencesUtils{
  /*
   * 存储数据
   */
  static Future save(List<NewsTitles> titles) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('titleList',titles.toString());
    print("SharedPreferencesUtils" + titles.toString());
//    Map<String, dynamic> user = json.decode(titles.toString());
//    print('存储acount为:$account');
  }

  /*
   * 读取数据
   */
  static Future _readShared() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String titleList = preferences.get('titleList');
    print('读取到acount为:$titleList');
  }

  /*
   * 删除数据
   */
  Future _removeShared() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('titleList');
    print('titleList');
  }
}