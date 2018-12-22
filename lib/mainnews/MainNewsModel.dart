class MainNewsModel{
  final String _id;
  final String en_name;
  final String name;
  final String created_at;
  final String icon;
  final String id;
  final String title;
  MainNewsModel(this._id,this.en_name,this.name,this.created_at,this.icon,this.id,this.title);
  MainNewsModel.fromJson(Map<String, dynamic> json)
      : _id = json['_id'],
        en_name = json['en_name'],
        name = json['name'],
        created_at = json['created_at'],
        icon = json['icon'],
        id = json['id'],
        title = json['title'];
}