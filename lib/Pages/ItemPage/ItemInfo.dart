import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bonnie_invest/Pages/DynamicsPage/DynamicPage.dart';
class ItemInfo extends StatefulWidget {
  ItemInfoState createState() => ItemInfoState();
}

class ItemInfoState extends State<ItemInfo> {
  //var width = ScreenUtil.screenWidth;
  int _index = 0;
  List<Widget> list = List<Widget>();
  void initState(){
    list
      ..add(ItemDynamics())
      ..add(Information());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
//      appBar: new AppBar(
//        title: new Text("项目信息"),
//      ),
      body: Form(child: Container(
        child: ListView(
          children: <Widget>[
          //  title(),
            Cover(),
            Info(),
            show(),
            divider(),
          words(),
          //  list[_index],
          ],
        ),
      )),
    );
  }

  Widget Cover() {
    return Padding(
      padding: const EdgeInsets.only(top: 0.0),
        child: new Column(
          children: <Widget>[
            new Image.asset(
              "images/popo1.jpg",
              width: 400.0,
              height: 260.0,
              fit: BoxFit.fill,
            ),
          ],
        )
    );
  }

  Widget Info(){
    return Container(
      child: new Padding(
        padding: const EdgeInsets.only(top:10.0,left: 40.0),
        child: new Row(
          children: <Widget>[
            new SizedBox(
              child: new Column(
                children: <Widget>[
                  new Text("0人",style: new TextStyle(fontSize: 20.0),),
                  new Text("本月订阅者",style: new TextStyle(fontSize: 15.0,color: Colors.grey),)
                ],
              ),
            ),
            new Padding(padding: const EdgeInsets.only(left:50.0)),
            new SizedBox(
              child: new Column(
                children: <Widget>[
                  new Text("0元",style: new TextStyle(fontSize: 20.0),),
                  new Text("本月订阅金额",style: new TextStyle(fontSize: 15.0,color: Colors.grey),)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Divider divider() {
    return Divider(
      indent: 1.0,
    );
  }


  Widget show(){
    return Container(
      child: new Padding(
        padding: const EdgeInsets.only(top:10.0,left: 40.0),
        child: new Row(
          children: <Widget>[
            new Padding(
              padding:const EdgeInsets.only(right: 25.0),
                child: new InkWell(
                  onTap: (){

                    //   ItemDynamics();
                  },
                  child: Text("动态",style: new TextStyle(fontSize: 20.0,color:Colors.grey),),
                )
            ),
            new Padding(
                padding:const EdgeInsets.only(right: 25.0),
              child: new InkWell(
                onTap: (){

               //   ItemDynamics();
                },
                child: Text("详情",style: new TextStyle(fontSize: 20.0,color:Colors.black),),
              )
            ),
            new Padding(
                padding:const EdgeInsets.only(right: 25.0),
                child: new InkWell(
                  onTap: (){

                    //   ItemDynamics();
                  },
                  child: Text("订阅者",style: new TextStyle(fontSize: 20.0,color:Colors.grey),),
                )
            ),
//            new InkWell(
//              onTap: (){
//                ItemDynamics();
//              },
//              child: Text("动态",style: new TextStyle(),),
//            ),
//            new Text("动态"),
//            new Text("详情"),
//            new Text("订阅者")
          ],
        ),
      ),
    );
  }

  Widget words(){
    return Container(
      child: new Padding(
        padding: const EdgeInsets.only(top:10.0,left: 30.0),
        child: new InkWell(
          child: new Text("这是我的项目详情。",style: new TextStyle(fontSize: 15.0),),
        ),
      ),
    );
  }

  Widget ItemDynamics(){
    return Container(
      child: new Padding(
        padding: const EdgeInsets.only(top: 0.0),
        child: Column(
          children: <Widget>[
            new Container(
              color: Colors.grey,
              height: 10.0,
              width: 400.0,
            ),
            new Column(
              children: <Widget>[
                new Text("我是动态")
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget Information(){

  }
}


