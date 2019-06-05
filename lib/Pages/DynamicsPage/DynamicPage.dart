import 'dart:io';
import 'package:flutter/material.dart';
import 'package:bonnie_invest/model/Dynamics.dart';
import 'package:bonnie_invest/Pages/DynamicsPage/EditDynamics.dart';
import 'package:path_provider/path_provider.dart';
import 'package:bonnie_invest/utils/Event/EditDynamicEvent.dart';
import 'package:bonnie_invest/utils/OsApplication.dart';
import 'package:event_bus/event_bus.dart';
import 'package:bonnie_invest/Pages/DynamicsPage/story_item.dart';
import 'package:bonnie_invest/Pages/DynamicsPage/story_data.dart';
import 'package:bonnie_invest/utils/Event/LoginEvent.dart';

class DynamicScreen extends StatefulWidget {
  final String name = "lanye";

  @override
  State<StatefulWidget> createState() => DynamicScreenState();
}
class DynamicScreenState extends State<DynamicScreen> {
  @override
  EventBus eventBus = new EventBus();

  //获取应用文档目录并创建文件
  String username = "username";
  String title = "标题";
  String data = "内容";
  String time = DateTime.now().toString();
  List<Widget> images ;
  var _textFieldController = new TextEditingController();
  var _storageString = '';

  //初始化文件路径
  Future<File> getFile(String fileName) async {
    //获取应用文件目录
    Directory fileDirectory = await getApplicationDocumentsDirectory();
    //获取存储路径
    String filePath = fileDirectory.path;
    //创建文件夹？
    File file = new File(filePath + "/"+ fileName);
    if(!file.existsSync()) {
      file.createSync();
    }
    String notes = await file.readAsString();
  }

  //获取存在文件中的数据
  Future getString() async {
    final file = await getFile('file.text');
    var filePath = file.path;
    setState(() {
      file.readAsString().then((String value) {
        _storageString = value + '\n文件存储路径：' + filePath;
      });
    });
  }

  //利用文件存储数据
  saveString() async {
    final file = await getFile('file.text');
    file.writeAsString(_textFieldController.value.text.toString());
  }

  List<Dynamics> list;
  @override
  void initState() {
    super.initState();
    OsApplication.eventBus.on<EditDynamicEvent>().listen((event) {
      setState(() {
        if (event != null && event.title != null) {
          title = event.title;
          data = event.data;
          time = event.time;
          images = event.images;
          print("注册监听成功");
        } else {
          print("标题为空");
          print(event.title);
          print(event);
        }
      });
    });

//    OsApplication.eventBus.on<LoginEvent>().listen((event){
//      setState(() {
//        if (event != null && event.username != null) {
//          username = event.username;
//          print("注册监听成功");
//        } else {
//          print("姓名为空");
//          print(event.username);
//          print(event);
//        }
//      });
//    });
  }
//  Future<int> savenotes(String notes) async {
//    writeToFile(context,file,notes);
//  }



//  //将数据内容写入指定文件中
//  void writeToFile(BuildContext context,File file,String notes) async {
//    File file1 = await file.writeAsString(notes);
//    if(file1.existsSync()) {
//      Toast.show(context,'保存成功');
//    }
//  }
//
//  //读取存储到指定文件中的数据
//  void getNotesFromCache() async {
//    Directory documentsDir = a
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('关注'),
      ),
      body:ListView.builder(
        itemCount: storyData.length,
          itemBuilder: (BuildContext context,int index){
            return new StoryItem(storyData[index]);
          }),

      //getContentSliver(context, list),


//      new Container(
//        child: ListView(
//          children: <Widget>[
//            //fan(),
//            //message(),
//            //getCommonItem(),
//
//            divider(),
//          ],
//        ),
//      ),

      floatingActionButton: new FloatingActionButton(
        mini: true,
        backgroundColor:Colors.grey,
        onPressed: () {
//            showButton();
          Navigator.of(context)
              .push(new MaterialPageRoute(builder: (context){
            return new EditMsg();
          }));
        },
        heroTag: 2,
        child: new Icon(Icons.create),
        elevation: 3.0,
        highlightElevation: 2.0,
      ),

    );
  }

  getContentSliver(BuildContext context,List<Dynamics> list){
   if(list == null || list.length == 0){
     return Text('暂无数据');
   }
   return SafeArea(
     top: false,
     bottom: false,
     child: Builder(
         builder: (BuildContext context){
           return CustomScrollView(
             physics: const BouncingScrollPhysics(),
             key: PageStorageKey<String>(widget.name),
             slivers: <Widget>[
               SliverOverlapAbsorber(
                 handle:
                 NestedScrollView.sliverOverlapAbsorberHandleFor(context),
               ),
               SliverList(
                   delegate: SliverChildBuilderDelegate(
                       ((BuildContext context,int index){
                         return getCommonItem(list, index);
                       }),childCount:list.length)),

             ],
           );
         }),
   );
  }

  Widget fan(){
    return Container(
      child: new Row(
        children: <Widget>[
          new Text("关注",style: new TextStyle(fontSize: 30.0),),
          new Text("精选",style: new TextStyle(fontSize: 30.0),),
        ],
      ),
    );
  }


//列表的普通单个item
  getCommonItem(List<Dynamics> items,int index){
    Dynamics item = items[index];

    return Container(

      margin: const EdgeInsets.only(bottom: 10.0),
      padding: const EdgeInsets.only(

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(
                radius: 25.0,
                backgroundImage: FileImage(File("images/zy.jpg")),
                backgroundColor: Colors.white,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(title),
              ),
              Expanded(
                child: Align(
                  child: Icon(
                    Icons.more_horiz,
                    color: Colors.grey,
                    size: 18.0,
                  ),
                  alignment: Alignment.centerRight,
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0,right: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                //Image.asset(name)
                Icon(Icons.favorite_border),
                Icon(Icons.comment),
              ],
            ),
          ),
          
        ],
      ),
    );
  }

  getItemCenterImg(Dynamics dynamics) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
//        Expanded(
//          child: RadiusImg.get(dynamics.image.large,null,
//            shape:RoundedRectangleBorder(
//              borderRadius: BorderRadius.only(
//                topLeft: Radius.circular(5.0),
//                bottomLeft: Radius.circular(5.0)
//              ),
//            )
//          ),
//        ),
//        Expanded(child: RadiusImg.get(),),
//        Expanded(
//          child: Radius.get(dynamics.casts[2].avatars.medium,null,
//            shape:
//          ),
//        )
      ],
    );
  }

Widget message() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        child: new Column(
          children: <Widget>[
            new Row(
              children: <Widget>[
                new Icon(Icons.people_outline),
                new Padding(padding: const EdgeInsets.only(left:10.0)),
                new Column(
                  children: <Widget>[
                    new Text(username,style: new TextStyle(fontSize: 15.0),),
                    new Text(time,style: new TextStyle(fontSize: 10.0),),
                  ],
                ),
              ],
            ),
            new Padding(padding: const EdgeInsets.all(5.0)),
            new Text(title,style: new TextStyle(fontSize: 20.0,),),
            new Padding(padding: const EdgeInsets.all(5.0)),
            new Text(data,style: new TextStyle(fontSize: 15.0),),
            new Wrap(
              children: images,
            )
          ],
        ),
      ),
    );
}

Divider divider() {
    return Divider(
      height: 1.0,
      color: Colors.grey,
    );
}
}

