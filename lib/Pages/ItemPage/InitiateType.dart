import 'dart:io';
import 'package:flutter/material.dart';
import 'package:bonnie_invest/Pages/ItemPage/ItemType.dart';

class InitiateType extends StatefulWidget {
  @override
  InitiateTypeState createState() => InitiateTypeState();
}

class InitiateTypeState extends State<InitiateType> {
  @override
  Widget build (BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("选择发起类型"),
      ),
      body: Form(
          child: Container(
            child: ListView(
              children: <Widget>[
                item(),
                divider(),


              ],
            ),
      )),
    );
  }

Widget item (){
    
    return Container(
      
      padding: const EdgeInsets.all(30.0),
      child: InkWell(
        onTap: (){
          Navigator.of(context)
              .push(new MaterialPageRoute(builder: (context){
            return new ItemType();
          }));
        },
        child: Column(
          
          children: <Widget>[
           
            
            
            Text("项目式众筹",
              style:new TextStyle(fontSize: 25.0,color: Colors.black),
              textAlign: TextAlign.center,),
            Text('需要一笔一次性的启动资金来完成项目，在一定期限内募集所需资金',
              style:new TextStyle(fontSize: 15.0,color: Colors.black),
              textAlign: TextAlign.center,),
          ],
        )
      ),
    );
  }
  Divider divider(){
    return Divider(
      height: 1.0,
      color: Colors.grey,
    );
  }
}