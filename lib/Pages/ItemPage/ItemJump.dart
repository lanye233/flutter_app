import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bonnie_invest/Pages/DynamicsPage/DynamicPage.dart';
import 'package:bonnie_invest/utils/OsApplication.dart';
import 'package:bonnie_invest/utils/Event/EditItemEvent.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
class ItemJump extends StatefulWidget {
  ItemJumpState createState() => ItemJumpState();
}

class ItemJumpState extends State<ItemJump> {
  //var width = ScreenUtil.screenWidth;
  int _index = 0;
  List<Widget> list = List<Widget>();
//  String title = 'qq';
//  String words = 'qq';
//  String begin = 'qq';
//  String over = 'qq';
//  //DateTime begin = DateTime.now();
//  //DateTime over = DateTime.now();
//  String money = 'qq';
  String title ;
  String words ;
  String begin;
  String over ;
  //DateTime begin = DateTime.now();
  //DateTime over = DateTime.now();
  String money;

  var date = new DateFormat('yyyy-MM-dd');
  InputType inputType = InputType.date;
  bool editable = true;

  @override
  void initState() {
    super.initState();
   // _getUserInfo();
    OsApplication.eventBus.on<EditItemEvent>().listen((event){
      setState((){
        if (event != null && event.title != null) {
          title = event.title;
          words = event.words;
          begin = event.begin.toString().substring(0,10);
          over = event.over.toString().substring(0,10);
          money = event.money;
          //_image = event.url;
          print("修改监听成功");
        } else {
          title = "mad";
          words = null;
          print("监听失败");
          print(event.title);
          print(event);
        }
      });
    });
  }

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
            T(),
            divider(),
           // Image(),
            Info(),
            divider(),
            show(),
            divider(),
            word(),
            //  list[_index],
          ],
        ),
      )),
    );
  }

  Widget T(){
    return Container(
      child: Column(
        children: <Widget>[
          new Text("$title",style: new TextStyle(fontSize: 25.0),),
        ],
      ),
    );
  }
  
  Widget Cover() {
    return Padding(
        padding: const EdgeInsets.only(top: 0.0),
        child: new Column(
          children: <Widget>[
            new Container(
              child:Image.asset("images/popo1.jpg"),
            )
          ],
        )
    );
  }

  Widget Info(){
    return Container(
      child: new Padding(
        padding: const EdgeInsets.only(top:0.0,left: 35.0),
        child: new Row(
          children: <Widget>[

            new SizedBox(
              child: new Column(
                children: <Widget>[
                  new Text(begin,style: new TextStyle(fontSize: 12.0),),
                  new Text("开始时间",style: new TextStyle(fontSize: 15.0,color: Colors.grey),)
                ],
              ),
            ),

            new Padding(padding: const EdgeInsets.only(left:50.0)),
            new SizedBox(
              child: new Column(
                children: <Widget>[
                  new Text(over,style: new TextStyle(fontSize: 12.0),),
                  new Text("结束时间",style: new TextStyle(fontSize: 15.0,color: Colors.grey),)

                ],
              ),
            ),
            new Padding(padding: const EdgeInsets.only(left:50.0)),
            new SizedBox(
              child: new Column(
                children: <Widget>[
                  new Text("$money "+"元",style: new TextStyle(fontSize: 12.0),),
                  new Text("预期金额",style: new TextStyle(fontSize: 15.0,color: Colors.grey),)

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
        padding: const EdgeInsets.only(top:10.0,left: 35.0),
        child: new Row(
          children: <Widget>[
//            new Padding(
//                padding:const EdgeInsets.only(right: 25.0),
//                child: new InkWell(
//                  onTap: (){
//
//                    //   ItemDynamics();
//                  },
//                  child: Text("动态",style: new TextStyle(fontSize: 20.0,color:Colors.grey),),
//                )
//            ),
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

  Widget word(){
    return Container(
      child: new Padding(
        padding: const EdgeInsets.only(top:0.0,left: 30.0),
        child: new InkWell(
          child: new Text("$words",style: new TextStyle(fontSize: 15.0),),
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


