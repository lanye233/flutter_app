import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/material.dart';

class User {
  int id;
  String username;
  String password;
  String signature;
  String email;
  var url;
 //  image user_url;

  Map<String,dynamic> toMap(){
    var map = new Map<String,dynamic>();
    map ['id'] = id;
    map['username'] = username;
    map['password'] = password;
   // map['url'] = url;
    map['signature'] =signature;
    map['email'] = email;
    return map;
  }

  static User fromMap(Map<String,dynamic> map) {
    User user = new User();
    user.id = map['id'];
    user.username = map['username'];
    user.password = map['password'];
   // user.url = map['url'];
    user.signature = map['signature'];
    user.email = map['email'];
  }

  static List<User> fromMapList(dynamic mapList) {
    List<User> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

}