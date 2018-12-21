import 'dart:convert';

class GankNewsModel{
  final String _id;
  final String createdAt;
  final String desc;
  final String publishedAt;
  final String source;
  final String type;
  final String url;
  final bool used;
  final String who;
  final List images;
  const GankNewsModel(this._id, this.createdAt, this.desc, this.publishedAt, this.source,
      this.type, this.url, this.used, this.who,this.images);

  @override
  String toString() {
    return 'GankNewsModel{_id: $_id, createdAt: $createdAt, desc: $desc, publishedAt: $publishedAt, source: $source, type: $type, url: $url, used: $used, who: $who}';
  }

  GankNewsModel.fromJson(Map<String, dynamic> json)
      : _id = json['_id'],
        createdAt = json['createdAt'],
        desc = json['desc'],
        publishedAt = json['publishedAt'],
        source = json['source'],
        type = json['publishedAt'],
        url = json['url'],
        used = json['used'],
        who = json['who'],
        images = json['images'];
}