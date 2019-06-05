import 'package:bonnie_invest/utils//OsApplication.dart';
import 'package:bonnie_invest/domain/UserInfoBean.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SpUtils {
  static const SP_ID = 'sp_id';
  static const SP_NAME = 'sp_name';
  static const SP_EMAIL = 'sp_email';
  static const SP_URL = 'sp_url';

  static const SP_TOKEN_TYPE = 'sp_token_type';
  static const SP_EXPIRES_IN = 'sp_expires_in';

  static const SP_COOKIE = 'sp_cookie';

// 保存用户信息
  static void saveUserInfo(UserInfoBean userInfo) async {
    if (userInfo != null) {
      SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
      sharedPreferences.setString(SP_ID, userInfo.id.toString());
      sharedPreferences.setString(SP_NAME, userInfo.username);
      sharedPreferences.setString(SP_EMAIL, userInfo.email);
    }
  }

// 清除用户信息
  static void cleanUserInfo() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(SP_ID, null);
    sharedPreferences.setString(SP_NAME, null);
    sharedPreferences.setString(SP_EMAIL, null);
    saveCookie(null);
    OsApplication.cookie=null;
  }

//  获取用户信息
  static Future<UserInfoBean> getUserInfo() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var id = sharedPreferences.getInt(SP_ID);
    var name = sharedPreferences.getString(SP_NAME);
    var email = sharedPreferences.getString(SP_EMAIL);
    Image url = sharedPreferences.get(SP_URL);
    UserInfoBean userInfo = new UserInfoBean(
      id,
      name,
      email,
      url,
    );
    return userInfo;
  }

//  把map转为UserInfoBean
  static Future<UserInfoBean> map2UserInfo(Map map) async {
    if (map != null) {
      var id = map['id'];
      var name = map['username'];
      var email = map['email'];
      Image url = map['url'];
      UserInfoBean userInfoBean = new UserInfoBean(id, name, email, url);
      return userInfoBean;
    } else {
      return null;
    }
  }

//  保存token等信息
  static void saveTokenInfo(Map map) async {
    if (map != null) {
      var tokenType = map['token_type'];
      var expiresIn = map['expires_in'];

      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setString(SP_TOKEN_TYPE, tokenType);
      sp.setString(SP_EXPIRES_IN, expiresIn.toString());
    }
  }

  static void saveCookie(var cookie) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(SP_COOKIE, cookie);
  }

  static Future<String> getCookie() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var cookieStr = sharedPreferences.getString(SP_COOKIE);
    return cookieStr;
  }
}
