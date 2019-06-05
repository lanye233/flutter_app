import 'package:flutter/material.dart';
import 'package:bonnie_invest/main.dart';
import 'package:bonnie_invest/Pages/HomePage/BottomNavigationWidget.dart';
import 'package:bonnie_invest/Pages/MessagePage/ChatList.dart';
import 'package:bonnie_invest/Pages/MessagePage/NoticePage.dart';

class ShowMsg extends StatelessWidget {

  @override
// 'ChatList':(BuildeContext) => new ChatList();
  Widget build (BuildContext context){
    return new Scaffold(
      appBar:new AppBar(
        title:new Text("消息"),
      ),
      body:
      new ListView(
        children: <Widget>[
          new ListTile(
            leading: new Icon(Icons.notifications_none),
            title: new Text("通知"),
            onTap: (){
  //            Navigator.of(context).pushNamed("NoticePage");
              Navigator.of(context)
                  .push(new MaterialPageRoute(builder: (context){
                return new NoticePage();
              }));
            },
          ),
          new ListTile(
            leading: new Icon(Icons.message),
            title: new Text("回复"),
            onTap: (){

            },
          ),
          new ListTile(
            leading: new Icon(Icons.people_outline),
            title: new Text("聊天"),
            onTap: (){
              Navigator.of(context)
                  .push(new MaterialPageRoute(builder: (context){
                return new ChatList();
              }));
            },
          ),
          new ListTile(
            leading: new Icon(Icons.favorite_border),
            title: new Text("点赞"),
            onTap: (){

            },
          ),
        ],
      )
    );
  }

  Widget routes (){
    new MaterialApp(
      routes:<String,WidgetBuilder>{
      'ChatList':(BuildeContext) => new ChatList(),
    },
    );
  }
}