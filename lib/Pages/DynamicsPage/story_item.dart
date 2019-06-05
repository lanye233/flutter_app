import 'package:flutter/material.dart';
import 'story_data.dart';
import 'package:date_format/date_format.dart';
import 'package:bonnie_invest/utils/touch_callback.dart';
import 'story_content.dart';
import 'package:bonnie_invest/Pages/DynamicsPage/story_data.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:event_bus/event_bus.dart';
import 'package:bonnie_invest/utils/OsApplication.dart';
import 'package:bonnie_invest/utils/Event/SaveStoryEvent.dart';
//class StoryItem extends StatefulWidget {
//  @override
//  State<StatefulWidget> createState() => StoryItemState();
//}
//class StoryItemState extends State<StoryItem> {
class StoryItem extends StatelessWidget {
  Story story;
  StoryItem(this.story);
  EventBus eventBus = new EventBus();
  void main(){
    print(this.story);
  }
  String image;
  String title;
  String subTitle;
  String description;
  List imageList;

//  @override
//  void initState() {
//    super.initState();
//    OsApplication.eventBus.on<SaveStoryEvent>().listen((event) {
//      setState(() {
//        if (event != null && event.subTitle != null) {
//          subTitle = event.subTitle;
//          title = event.title;
//          description = event.description;
//          imageList = event.imageList;
//          //_image = event.url;
//          print("修改监听成功");
//        } else {
//          subTitle  = null;
//          userAvatar = null;
//          print("姓名为空");
//          print(event.username);
//          print(event);
//        }
//      });
//    });
//  }

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
                  child: Image.asset(story.image, width: 48.0, height: 48.0,),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center, // 垂直方向居中布局
                    crossAxisAlignment: CrossAxisAlignment.start, // 水平方向靠左对齐
                     children: <Widget>[
                       Text(
                        story.title,
                        style: TextStyle(fontSize: 16.0, color:Color(0xFF353535)),
                        maxLines: 1,
                       ),
                       Padding(
                         padding: const EdgeInsets.only(top: 8.0),
                       ),
                       Text(
                         story.subTitle,
                         style: TextStyle(fontSize: 14.0, color:Color(0xFF9a9a9a)),
                         maxLines: 1,
                         // 显示不完的文本用省略号来显示
                         overflow: TextOverflow.ellipsis,
                       ),
                     ],
                  ),
                ),
              ],
            ),
           new Container(
             padding: const EdgeInsets.only(left:10.0,right:10.0,top: 8.0,bottom: 8.0),
             child: Text(story.description),
           ),

          ],
        ),


        onPressed: () {
          // 跳转到新的页面
          Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
            return new StoryContent(story);
          }));
        },

      ),

    );
  }
}