import 'package:flutter/material.dart';

class Item {
//  int id;
  String title;
  String type;
  String words;
  String money;
  Image url;
  String begin;
  String over;

  Item(this.title,this.words,this.begin,this.over,this.money);

  Map<String,dynamic> toMap() {
    var map = new Map<String,dynamic>();
  //  map ['id'] =id;
    map ['title'] = title;
    map ['words'] = words;
    map ['type'] = type;
    map ['url'] = url;
    map ['begin'] = begin;
    map ['over'] = over;
    map ['money'] =money;
    return map;
  }

  static Item fromMap(Map<String,dynamic> map) {
    Item item ;
 //   item.id = map ['id'];
    item.title = map ['title'];
    item.words = map ['words'];
    item.type = map['type'];
    item.url = map ['url'];
    item.begin = map ['begin'];
    item.over = map ['over'];
    item.money = map ['money'];
  }

  static List<Item> fromMapList(dynamic mapList) {
    List<Item> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

  void addItem(title, words, begin, over, money){
    //  List<Story> storyData = List();
    Item item = new Item(title, words, begin, over, money);
    itemData.add(item);
    print("增加item");
  }

}

List<Item> itemData = [
  new Item(
    '音乐项目标题',
    '这是我的音乐项目详情内容，这是我的音乐项目详情内容，这是我的音乐项目详情内容，这是我的音乐项目详情内容，这是我的音乐项目详情内容。',
    '2019-4-1',
    '2019-4-30',
    '30000',
    ),
  new Item('电影项目标题', '这是我的电影项目详情内容', '2019-5-1', '2019-5-23', '50000',),
];