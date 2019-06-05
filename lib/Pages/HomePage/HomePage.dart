import 'package:flutter/material.dart';
import 'package:bonnie_invest/Pages/HomePage/SearchBarDemo.dart';
import 'package:bonnie_invest/Pages/HomePage/BannerViewPage.dart';
class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeScreenState();
}
class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
      return new MaterialApp(
        //   title: SearchBarDemo(),
        theme: new ThemeData.light(),
        home:new Scaffold(
          appBar: AppBar(

            actions: <Widget>[

            ],
            title: SearchBarDemo(),
          ),
          body:new Container(
            child: new Column(
              children: <Widget>[
              //  SearchBarDemo(),
                buildBanner(),
              ],
            ),
          )

         // buildBanner(),
        ),

      );
  }
  Widget buildBanner(){
    return new Container(
      alignment: Alignment.center,
        height: 200.0,
      child: new BannerView(
        data:<Widget>[
          Image.asset("images/banner1.jpg"),
          Image.asset("images/banner2.jpg"),
          Image.asset("images/banner3.jpg"),
          Image.asset("images/popo1.jpg"),
          Image.asset("images/popo2.jpg"),
          Image.asset("images/yyyy.jpg"),
        ]
      ),
    );
  }
}
