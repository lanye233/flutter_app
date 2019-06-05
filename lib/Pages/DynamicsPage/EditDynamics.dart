import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bonnie_invest/Pages/DynamicsPage/DynamicPage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:bonnie_invest/utils/Event/SaveStoryEvent.dart';
import 'package:bonnie_invest/utils/OsApplication.dart';
import 'package:bonnie_invest/Pages/DynamicsPage/story_data.dart';
import 'package:bonnie_invest/model/DatabaseHelper.dart';
class EditMsg extends StatefulWidget {
  @override

  EditMsgState createState() => EditMsgState();
}

class EditMsgState extends State<EditMsg> {
  var db = new DatabaseHelper();
  Story story;
  DateTime time = DateTime.now();

  var _titleController = new TextEditingController();
  var _dataController = new TextEditingController();
  var _storageString = '';

  //初始化文件路径
  Future<File> getFile(String fileName) async {
    //获取应用文件目录
    final fileDirectory = await getApplicationDocumentsDirectory();
    //获取存储路径
    final filePath = fileDirectory.path;
    //创建文件夹？
    File file = new File(filePath + "/"+ fileName);
    if(!file.existsSync()) {
      file.createSync();
    }
    debugPrint("$filePath");
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
    file.writeAsString(_titleController.text.toString());

    debugPrint("$file.Path");
  }

  File _imagePath;

  List<Story> _datas = new List();

  //查询
  Future<Null> _query() async{
    _datas.clear();
    List datas = await db.getTotalLists('story');
    if(datas.length > 0) {
      //数据库有数据
      datas.forEach((story){
        Story dataListBean = Story.fromMap(story);
        _datas.add(dataListBean);
      });
    }
//    setState(() {
//    });
    print(datas);
  }

  Future getImage() async {
    File file =await ImagePicker.pickImage(source: ImageSource.gallery);
    if (file != null){
      setState(() {
        _imagePath = file;
      });
    }
    list.insert(list.length-1, addPictures());
  }

  List<Widget> list;

  void initState(){
    super.initState();
//    if(list.length < 9){
//      list =List<Widget>()..add(buildAddButton());
//    } else {
//      list = List<Widget>();
//    }


    list =List<Widget>()..add(buildAddButton());
  }

  save() {
    String id = "100";
    String Title = _titleController.text.toString();
    String Image = "images/cover/01.jpg";
    String Description = _dataController.text.toString();
    String SubTitle = DateTime.now().toString().substring(0,10);
    
    List imageList = list;
    Story story = new Story(Image, Title, SubTitle, Description,imageList);
    story.title =Title;
    story.subTitle = SubTitle;
    story.description = Description;
    story.addStory(Image, Title, SubTitle, Description,imageList);

    story.show();
//    story.imageList = list;
//    db.saveStory(story);
 //   _query();
    //存储story
    print("点击存储 + $Title + $SubTitle + $Description");
 //   OsApplication.eventBus.fire(new SaveStoryEvent(title, subTitle, description));
  }

  @override


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
   //     title: new Text("发布"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),color: Colors.white,
            onPressed: (){
              save();
              Navigator.pop(context);
             // saveString();
           //   debugPrint("$_imagePath");
            }
          )
        ],

      ),
      body:Form(
        child: Container(
          child: ListView(
            children: <Widget>[
              Title(),
              divider(),
              words(),
              divider(),
              showlist(),
            ],
          ),
        ),
      ),
    );
  }

  Widget showlist(){
    return Wrap(
      children:list,
    );
  }

  TextField Title (){
    return TextField(
      controller: _titleController,
      style: TextStyle(
        fontSize: 25,
      ),
      maxLength: 26,
      maxLines: 1,
        decoration: InputDecoration(
        hintText: "输入标题（选填）",
        border: InputBorder.none,
 //       contentPadding: const EdgeInsets.all(10.0),
        ),
    );
  }

  TextField words (){
    return TextField(
      controller: _dataController,
      style: TextStyle(
        fontSize: 15
      ),
      maxLength: 5000,
      maxLines: 10,
        decoration: InputDecoration(
        hintText: "分享有趣的事……",
        border: InputBorder.none,
 //       contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
        )
    );
  }

  Divider divider(){
    return Divider(
      height: 1.0,
      color: Colors.grey,
    );
  }

  Widget buildAddButton(){
    return GestureDetector(
      onTap: (){
        if(list.length<9){
          setState(() {
            getImage();
          });
        } else {
          setState(() {
          });
        }
      },
      child: Padding(
          padding:const EdgeInsets.all(5.0),
          child:Container(
            width: 100.0,
            height: 100.0,
            child: Icon(Icons.add),
            decoration: new BoxDecoration(
              border: new Border.all(color: Colors.grey),
              borderRadius: new BorderRadius.circular(5.0)
            ),
          )
      ),
    );
  }

Widget addPictures(){
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child:  SizedBox(
        height: 100.0,
        width: 100.0,
        child:  Container(
          decoration: new BoxDecoration(
            border: new Border.all(color:Colors.grey),
            borderRadius: new BorderRadius.circular(5.0)
          ),
          child: new InkWell(
            child:
            Image.file(_imagePath,fit: BoxFit.cover,),
          ),
        ),
      ),
    );
  }
}

