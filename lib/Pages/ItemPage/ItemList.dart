import 'package:flutter/material.dart';
import 'package:bonnie_invest/main.dart';
import 'package:bonnie_invest/Pages/HomePage/BottomNavigationWidget.dart';
import 'package:bonnie_invest/Pages/MessagePage/ChatList.dart';
import 'package:bonnie_invest/Pages/MessagePage/NoticePage.dart';
import 'package:bonnie_invest/model/Item.dart';
import 'package:bonnie_invest/Pages/ItemPage/ItemJump.dart';
import 'package:bonnie_invest/model/DatabaseHelper.dart';
import 'package:bonnie_invest/Pages/ItemPage/MyItemList.dart';
class ItemList extends StatelessWidget {
  var db = new DatabaseHelper();
  Item item ;
  List<Item> _datas = new List();
  Future<Null> query() async {
    _datas.clear();
    List datas = await db.getTotalLists('tableUser');
    if(datas.length > 0) {
      //数据库有数据
      datas.forEach((user){
        Item dataListBean = Item.fromMap(user);
        _datas.add(dataListBean);
      });
    }
//    setState(() {
//    });
    print(datas);
  }

  @override
// 'ChLatList':(BuildeContext) => new ChatList();
  Widget build (BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('关注'),
      ),
      body:ListView.builder(
          itemCount: itemData.length,
          itemBuilder: (BuildContext context,int index){
            return new MyItemList(itemData[index]);
          }),

    );
  }

}