import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:permission/permission.dart';
import 'package:simple_permissions/simple_permissions.dart';
import 'package:bonnie_invest/Pages/HomePage/BottomNavigationWidget.dart';
import 'package:bonnie_invest/Pages/MessagePage/ChatList.dart';
void main() {
  runApp(new MaterialApp(
    home:new MyApp(),
    routes:<String,WidgetBuilder>{
      'ChatList':(BuildeContext) => new ChatList(),
    },
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
//  String _platformVersion = 'Unknown';
//  Permission permission;
//
//  @override
//  initState() {
//    super.initState();
//    initPlatformState();
//  }
//
//  initPlatformState() async{
//    String platformVersion;
//    try{
//      platformVersion = await SimplePermissions.platformVersion;
//    } on PlatformException {
//      platformVersion = 'Failed to get platform version';
//    }
//    if(!mounted) return;
//    setState(() {
//      _platformVersion = platformVersion;
//    });
//  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Invest Project Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BottomNavigationWidget(),
    );
  }
}


