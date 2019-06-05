import 'package:flutter/material.dart';
import 'package:bonnie_invest/model/Item.dart';
import 'package:date_format/date_format.dart';
import 'package:bonnie_invest/utils/touch_callback.dart';
import 'package:bonnie_invest/Pages/DynamicsPage/story_data.dart';
import 'package:event_bus/event_bus.dart';
import 'package:bonnie_invest/Pages/ItemPage/MyItemInfo.dart';
import 'package:bonnie_invest/Pages/ItemPage/ItemJump.dart';
import 'package:bonnie_invest/Pages/ItemPage/ItemInfo.dart';
import 'package:bonnie_invest/utils/OsApplication.dart';
import 'package:bonnie_invest/utils/Event/SaveStoryEvent.dart';
import 'package:bonnie_invest/utils/Event/ItemListInfoEvent.dart';
import 'package:bonnie_invest/utils/OsApplication.dart';
//class StoryItem extends StatefulWidget {
//  @override
//  State<StatefulWidget> createState() => StoryItemState();
//}
//class StoryItemState extends State<StoryItem> {
class MyItemList extends StatelessWidget {
  Item item;
  MyItemList(this.item);
  EventBus eventBus = new EventBus();
  void main(){
    print(this.item);
  }
//  String title;
//  String type;
//  String words;
//  String money;
//  Image url;
//  String begin;
//  String over;

  Future<Null> save() async{
 //   Item item;
    String title = item.title;
    String words = item.words;
    String begin = item.begin;
    String over = item.over;
    String money = item.money;

    print("点击查看个人项目信息+$title+$begin");
    OsApplication.eventBus3.fire(new ItemListInfoEvent(title, words, begin, over, money));
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        // 底部边
        border:
        Border(bottom: BorderSide(width: 0.5, color: Color(0xFFd9d9d9))),
      ),
      //height: 150.0,
      // 按下回调处理空实现
      child: TouchCallBack(
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(left: 13.0, right: 13.0),
                  child: new Icon(Icons.chevron_right),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center, // 垂直方向居中布局
                    crossAxisAlignment: CrossAxisAlignment.start, // 水平方向靠左对齐
                    children: <Widget>[
                      Text(
                        item.title,

                        style: TextStyle(fontSize: 16.0, color:Color(0xFF353535)),
                        maxLines: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            item.begin,
                            style: TextStyle(fontSize: 14.0, color:Color(0xFF9a9a9a)),
                            maxLines: 1,
                            // 显示不完的文本用省略号来显示
                            overflow: TextOverflow.ellipsis,
                          ),
                          Padding(
                              padding: const EdgeInsets.only(left: 10.0)),
                          Text(
                            "至",
                            style: TextStyle(fontSize: 14.0, color:Color(0xFF9a9a9a)),
                            maxLines: 1,
                            // 显示不完的文本用省略号来显示
                            overflow: TextOverflow.ellipsis,
                          ),
                          Padding(
                              padding: const EdgeInsets.only(left: 10.0)),
                          Text(
                            item.over,
                            style: TextStyle(fontSize: 14.0, color:Color(0xFF9a9a9a)),
                            maxLines: 1,
                            // 显示不完的文本用省略号来显示
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
//                Padding(
//                    padding: const EdgeInsets.only(left: 5.0,right: 20.0)),
                Container(
                  margin: const EdgeInsets.only(left: 13.0, right: 30.0),
                  child:
                    Text(
                      item.money+"元",
                      style: TextStyle(fontSize: 14.0, color:Color(0xFF9a9a9a)),
                      maxLines: 1,
                      // 显示不完的文本用省略号来显示
                      overflow: TextOverflow.ellipsis,
                    ),
                ),

              ],
            ),
            new Divider(
              height: 10.0,
            ),
            new Container(
              padding: const EdgeInsets.only(left:10.0,right:10.0,top: 8.0,bottom: 8.0),
              child: Text(item.words),
            ),

          ],
        ),


        onPressed: () {
          save();
       //   print("点击跳转");
          // 跳转到新的页面
          Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
            return new MyItemInfo();
          }));
        },

      ),

    );
  }
}