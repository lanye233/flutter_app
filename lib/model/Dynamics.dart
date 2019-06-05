import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sql.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:image/image.dart';
class Dynamics {
  String name;
  String datas;
  Image url;
  DateTime date;

  Map<String,dynamic> toMap() {
    var map = new Map<String,dynamic>();
    map['name'] =name;
    map ['datas'] = datas;
    map ['url'] = url;
    map ['date'] =date;
    return map;
  }
  static Dynamics fromMap(Map<String,dynamic> map) {
    Dynamics dynamics = new Dynamics();
    dynamics.name =map['name'];
    dynamics.datas = map ['datas'];
    dynamics.url = map['url'];
    dynamics.date = map['date'];
  }
  static List<Dynamics> fromMapList(dynamic mapList) {
    List<Dynamics> list = new List(mapList.length);
    for(int i= 0;i<mapList.length;i++) {
      list[i] = fromMap(mapList);
    }
    return list;
  }

}