import 'dart:ui';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bonnie_invest/Pages/DynamicsPage/DynamicPage.dart';
import 'package:bonnie_invest/utils/OsApplication.dart';
import 'package:bonnie_invest/utils/Event/EditItemEvent.dart';
import 'package:bonnie_invest/utils/Event/ItemListInfoEvent.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:event_bus/event_bus.dart';
class MyItemInfo extends StatefulWidget {
  MyItemInfoState createState() => MyItemInfoState();
}

class MyItemInfoState extends State<MyItemInfo> {
  //var width = ScreenUtil.screenWidth;

  String title = "项目标题";

  int _index = 0;
  List<Widget> list = List<Widget>();

  String words = "项目详情";
  String begin = "2019-5-1";
  String over = "2019-5-31";
  //DateTime begin = DateTime.now();
  //DateTime over = DateTime.now();
  String money = "20000";


  @override
//  EventBus eventBus3 = null;
  var date = new DateFormat('yyyy-MM-dd');
  InputType inputType = InputType.date;
  bool editable = true;
  StreamController _streamController;

  StreamSubscription subscriptionType =null;
//  StreamSubscription subscriptionData =null;
//  EventBus() {
//    _streamController = new StreamController.b
//  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    subscriptionType.cancel();
    print("取消");//  取消
  //  subscriptionData.cancel();
  }


  @override
  void initState() {
    print("理论");
    super.initState();
    // _getUserInfo();
    print("执行");
    subscriptionType=OsApplication.eventBus3.on<ItemListInfoEvent>().listen((event3){
      print("啦啦");
 //     if (mounted) {
        setState((){
          if (event3 != null ) {
            title = event3.title;
            words = event3.words;
            begin = event3.begin.toString().substring(0,10);
            over = event3.over.toString().substring(0,10);
            money = event3.money;
            //_image = event.url;
            print("获取个人项目信息成功");
          } else {
            title = "mad";
            words = null;
            print("获取失败");
            print(event3.title);
            print(event3);
          }
        });
  //    }
    });
    subscriptionType.resume();
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
                  new Text('$begin',style: new TextStyle(fontSize: 12.0),),
                  new Text("开始时间",style: new TextStyle(fontSize: 15.0,color: Colors.grey),)
                ],
              ),
            ),

            new Padding(padding: const EdgeInsets.only(left:50.0)),
            new SizedBox(
              child: new Column(
                children: <Widget>[
                  new Text('$over',style: new TextStyle(fontSize: 12.0),),
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


