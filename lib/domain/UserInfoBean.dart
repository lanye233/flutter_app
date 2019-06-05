import 'package:flutter/material.dart';
import 'package:io/io.dart';

// 用户信息
class UserInfoBean {
  String username; //用户名
  num id;
  String email;
  var url;

  UserInfoBean(
      this.id,
      this.username,
      this.email,
      this.url,
      );

  //下面是获取各属性值的方法
  //String get name => name;

  Map<String,dynamic> toMap(){
    Map map = <String,dynamic>{
      'name':username,
    };
    if(id != null){
      map['id']=id;
    }
    return map;
  }
}