import 'dart:io';
import 'package:flutter/material.dart';
import 'package:bonnie_invest/Pages/ItemPage/EditItem/MusicItem.dart';
//import 'package:bonnie_invest/Pages/ItemPage/EditItem/GameItem.dart';
//import 'package:bonnie_invest/Pages/ItemPage/EditItem/MovieItem.dart';
//import 'package:bonnie_invest/Pages/ItemPage/EditItem/FoodItem.dart';
import 'package:bonnie_invest/Pages/ItemPage/ItemInfo.dart';

class ItemType extends StatefulWidget {
  @override
  ItemTypeState createState() => ItemTypeState();
}
class ItemTypeState extends State<ItemType> {

//  var titles =  ["游戏","电影","音乐"];
//  //String title = titles[index];
//  List<Icon> icons = [
//    Icon(Icons.games),Icon(Icons.movie),Icon(Icons.music_note),
//  ];


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("选择发起项目类型"),
      ),
      body: Form(child: Container(
        child: ListView(
          children: <Widget>[
            CrowdFunding(),
          ],
        ),
      )),
    );
  }

  Widget CrowdFunding() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        child: Column(
          children: <Widget>[
            Text("众筹", style: new TextStyle(fontSize: 25.0),
              textAlign: TextAlign.right,),
//            GridView.count(
//              crossAxisCount: 4, //一行几个
//              crossAxisSpacing: 10.0, //左右间隔
//              mainAxisSpacing: 10.0, //上下间隔
//              childAspectRatio:  3 / 4,
//              children: initList(20),
//            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              child:Row(
                children: <Widget>[
                  SizedBox(
                    width: 80.0,
                    height: 80.0,
                    child: new InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(new MaterialPageRoute(builder: (context){
                          return new MusicItem();
                        }));
                      },
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.games),
                          Text("游戏")
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    width: 80.0,
                    height: 80.0,
                    child: new InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(new MaterialPageRoute(builder: (context){
                          return new MusicItem();
                        }));
                      },
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.movie),
                          Text("电影")
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    width: 80.0,
                    height: 80.0,
                    child: new InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(new MaterialPageRoute(builder: (context){
                          return new MusicItem();
                        }));
                      },
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.music_note),
                          Text("音乐")
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    width: 80.0,
                    height: 80.0,
                    child: new InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(new MaterialPageRoute(builder: (context){
                          return new MusicItem();
                        }));
                      },
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.fastfood),
                          Text("食品")
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Container> initList(int count) {
    return new List.generate(
        count,

            (int index) =>
        new Container(
            child: Column(
              children: <Widget>[
                SizedBox(
                  width: 50.0,
                  height: 80.0,
                  child: new InkWell(
                    onTap: () {

                    },
                    child: Column(
                      children: <Widget>[
                        //   icons,
                        new Expanded(
                          //child: new Text(title)),
//                      new Expanded(
//                          child:
                        )
                      ],
                    ),
                  ),
                )
              ],
            )
        ));
  }

}

