import 'package:flutter/material.dart';
import 'package:bonnie_invest/Pages/HomePage/HomePage.dart';
import 'package:bonnie_invest/Pages/MessagePage/ShowMsg.dart';
import 'package:bonnie_invest/Pages/PersonPage/PersonPage.dart';
import 'package:bonnie_invest/Pages/DynamicsPage/DynamicPage.dart';
import 'package:bonnie_invest/Pages/ItemPage/InitiateType.dart';
import 'package:bonnie_invest/Pages/TestPage.dart';

class BottomNavigationWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BottomNavigationWidgetState();
}
class BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  final _bottomNavigationColor = Colors.blue;
  int _currentIndex = 0;
  List<Widget> list = List<Widget>();
  void initState(){
    list
      ..add(HomeScreen())
      ..add(DynamicScreen())
      ..add(ShowMsg())
      ..add(PersonScreen());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: list[_currentIndex],
      floatingActionButton: new FloatingActionButton(
          foregroundColor: Colors.white,
          //elevation: 10.0,
          onPressed: (){
            Navigator.of(context)
                .push(new MaterialPageRoute(builder: (context){
              return new InitiateType();
            }));

          },
          child: new Icon(Icons.add),
          mini: true,
          heroTag: 1,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: _bottomNavigationColor,
              ),
              title: Text(
                '首页',
                style: TextStyle(color: _bottomNavigationColor),
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.pages,
                color: _bottomNavigationColor,
              ),
              title: Text(
                '动态',
                style: TextStyle(color: _bottomNavigationColor),
              )),

//          BottomNavigationBarItem(
//            icon: Icon(
//              Icons.add,
//            )
//
//          ),
//
          BottomNavigationBarItem(
              icon: Icon(
                Icons.email,
                color: _bottomNavigationColor,
              ),
              title: Text(
                '消息',
                style: TextStyle(color: _bottomNavigationColor),
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: _bottomNavigationColor,
              ),
              title: Text(
                '我的',
                style: TextStyle(color: _bottomNavigationColor),
              )),
        ],
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
