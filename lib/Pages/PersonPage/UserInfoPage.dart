import 'dart:async';
import 'dart:io';
import 'package:bonnie_invest/utils/Event/LoginEvent.dart';
import 'package:bonnie_invest/utils/Event/PersonInfoEvent.dart';
import 'package:bonnie_invest/utils/Event/OldNameEvent.dart';
import 'package:bonnie_invest/utils/OsApplication.dart';
import 'package:flutter/material.dart';
import 'package:bonnie_invest/utils/WidgetsUtils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bonnie_invest/model/DatabaseHelper.dart';
import 'package:bonnie_invest/model/User.dart';
import 'package:event_bus/event_bus.dart';
import 'package:bonnie_invest/Pages/PersonPage/LoginPage.dart';
import 'package:bonnie_invest/Pages/PersonPage/PersonPage.dart';
class UserInfoPage extends StatefulWidget {
  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  EventBus eventBus1 = new EventBus();

  var _image;
  WidgetsUtils widgetsUtils;
  var log = new LoginPage();
  var db = new DatabaseHelper();
  String oldName;
  var _userNameController = new TextEditingController();
//  var _userRealNameController = new TextEditingController();
  var _userJobController = new TextEditingController();
  var _userEmailController = new TextEditingController();
  var _userIntroController = new TextEditingController();

  var leftRes = new TextStyle(fontSize: 16.0, color: Colors.black);
  var hintRes = new TextStyle(fontSize: 15.0, color: Color(0xff969696));

  @override
  void initState() {
    super.initState();
    OsApplication.eventBus1.on<OldNameEvent>().listen((event1){
      setState(() {
        if(event1 != null && event1.oldName != null){
          oldName = event1.oldName;
          print("获取旧名成功呀："+oldName);
        }else {
          oldName = null;
          print("失败");
        }
      });
    });
  }

  List<User> _datas = new List();
  //查询
  Future<Null> _query() async{
    _datas.clear();
    List datas = await db.getTotalLists('tableUser');
    if(datas.length > 0) {
      //数据库有数据
      datas.forEach((user){
        User dataListBean = User.fromMap(user);
        _datas.add(dataListBean);
      });
    }
    setState(() {
    });
    print(datas);
  }



  //更新数据
  Future<Null> _update() async {
    // initState();
//    OsApplication.eventBus1.on<OldNameEvent>().listen((event){
//      setState(() {
//        if(event != null && event.oldName != null){
//          oldName = event.oldName;
//          print("获取旧名成功呀："+oldName);
//        }else {
//          oldName = null;
//          print("失败");
//        }
//      });
//    });

    User user = new User();
    user.url = _image;
    user.username = _userNameController.text.toString();
    user.email = _userEmailController.text.toString();
    user.signature = _userIntroController.text.toString();
    await db.updateName(user.username,oldName);
    await db.updateEmail(user.email,oldName);
    await db.updateSignature(user.signature,oldName);
    //await db.update(user);
    print("更新数据："+user.username + "+" + user.email + "+" + user.signature +"旧名：$oldName");
    _query();
  }



  @override
  Widget build(BuildContext context) {
    widgetsUtils = new WidgetsUtils(context);
    return new Scaffold(
      appBar: new AppBar(
        title: widgetsUtils.getAppBar('用户信息'),
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      body: initInputBody(),
    );
  }

  Widget initInputBody() {
    List<Widget> items = [];
    items.addAll(initHeaderItem(null));
    items.addAll(initInputItem('用户名', '请输入用户名', _userNameController));
    items.addAll(initInputItem('邮箱', '请输入邮箱', _userEmailController));
//    items.addAll(initInputItem('真实姓名', '请输入真实姓名', _userRealNameController));
    items.addAll(initInputItem('职业', '请输入职业', _userJobController));
    items.addAll(
        initInputItem('简介', '介绍下自己吧', _userIntroController, maxLines: 6));
    items.add(initSubmitBtn());
   // items.add(off());
    return new Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: items,
    );
  }

  // 显示弹窗
  showPickDialog() {
    showModalBottomSheet(context: context, builder: _bottomPick);
  }

// 构建弹窗
  Widget _bottomPick(BuildContext context) {
    return initImgPick();
  }

  Future<String> getImgPick(ImageSource source) async {
    var tempImg = await ImagePicker.pickImage(source: source);
    setState(() {
      _image = tempImg;
    });
  }

  List<Widget> initHeaderItem(var userAvatar) {
    List<Widget> item = [];
    item.add(new InkWell(
      onTap: (() {
        showPickDialog();
      }),
      child: new Padding(
        padding: new EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new Container(
                child: new Text(
                  '头像',
                  style: leftRes,
                ),
                alignment: Alignment.centerLeft,
                height: 80.0,
              ),
            ),
            initHeaderView(userAvatar)
          ],
        ),
      ),
    ));
    item.add(new Divider(
      height: 1.0,
    ));
    return item;
  }

  Widget initHeaderView(var userAvatar) {
    if (_image == null) {
      if (userAvatar == null) {
        return new Image.asset(
          "images/ic_avatar_default.png",
          width: 60.0,
          height: 60.0,
        );
      } else {
        return new Container(
          width: 60.0,
          height: 60.0,
          decoration: new BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
              image: new DecorationImage(
                  image: new NetworkImage(userAvatar), fit: BoxFit.cover),
              border: new Border.all(color: Colors.white, width: 2.0)),
        );
      }
    } else {
      return new Container(
        width: 60.0,
        height: 60.0,
        decoration: new BoxDecoration(
            shape: BoxShape.circle,
            image: new DecorationImage(
                image: new FileImage(_image), fit: BoxFit.cover),
            border: new Border.all(color: Colors.white, width: 2.0)),
      );
    }
  }

//  初始化输入的item
  List<Widget> initInputItem(var leftMsg, var hintMsg, var controller,
      {var maxLines = 1}) {
    List<Widget> item = [];
    item.add(
      new Padding(
        padding: new EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new Container(
                child: new Text(
                  leftMsg,
                  style: leftRes,
                ),
                alignment: Alignment.centerLeft,
                height: 50.0,
              ),
            ),
            new Expanded(
                flex: 2,
                child: new Padding(
                  padding: new EdgeInsets.fromLTRB(0.0, 6.0, 0.0, 6.0),
                  child: new TextField(
                    style: hintRes,
                    maxLines: maxLines,
                    textAlign: maxLines == 1 ? TextAlign.end : TextAlign.end,
                    controller: controller,
                    decoration: InputDecoration.collapsed(hintText: hintMsg),
                    obscureText: false,
                  ),
                ))
          ],
        ),
      ),
    );
    item.add(new Divider(
      height: 1.0,
    ));
    return item;
  }

  Widget initSubmitBtn() {
    return new Container(
      width: 360.0,
      margin: new EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 0.0),
      child: new Card(
        color: Colors.blue,
        elevation: 2.0,
        child: new MaterialButton(
          onPressed: () {

            User user = new User();
            user.url = _image;
            user.username = _userNameController.text.toString();
            user.email = _userEmailController.text.toString();
            user.signature = _userIntroController.text.toString();
          //  _image;
           // OsApplication.eventBus.fire(new LoginEvent(user.username));
//            OsApplication.eventBus.on<LoginEvent>().listen((event){
//              setState(() {
//                if(event != null && event.username != null){
//                  oldName = event.username;
//                  print("旧名："+ oldName);
//                }else {
//                  print("失败");
//                }
//              });
//            });
            _update();
            OsApplication.eventBus.fire(new PersonInfoEvent(user.username, user.url, user.email, user.signature));

            Navigator.pop(context);
            print("点击修改");
          },
          child: new Text(
            '确认修改',
            style: new TextStyle(color: Colors.white, fontSize: 14.0),
          ),
        ),
      ),
    );
  }

  Widget off() {
    return new Container(
      width: 360.0,
      margin: new EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
      child: new Card(
        color: Colors.blue,
        elevation: 2.0,
        child: new MaterialButton(
          onPressed: () {
            Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
              return LoginPage();
            }));
          //  Navigator.pop(context);
            print("退出登录");
          },
          child: new Text(
            '退出登录',
            style: new TextStyle(color: Colors.white, fontSize: 14.0),
          ),
        ),
      ),
    );
  }


  Widget initImgPick() {
    return new Container(
        height: 170.0,
        child: new Column(
          children: <Widget>[
            new InkWell(
              child: new Container(
                child: new Text(
                  '拍照',
                  style: new TextStyle(color: Colors.black, fontSize: 15.0),
                ),
                height: 60.0,
                alignment: Alignment.center,
              ),
              onTap: (() {
                Navigator.of(context).pop();
                getImgPick(ImageSource.camera);
              }),
            ),
            new Divider(
              height: 1.0,
            ),
            new InkWell(
              onTap: (() {
                Navigator.of(context).pop();
                getImgPick(ImageSource.gallery);
              }),
              child: new Container(
                child: new Text(
                  '从手机相册选择',
                  style: new TextStyle(color: Colors.black, fontSize: 15.0),
                ),
                height: 60.0,
                alignment: Alignment.center,
              ),
            ),
            new Container(
              height: 5.0,
              color: new Color(0xfff2f2f2),
            ),
            new Container(
              child: new Text(
                '取消',
                style: new TextStyle(color: Colors.black, fontSize: 15.0),
              ),
              height: 40.0,
              alignment: Alignment.center,
            )
          ],
        ));
  }
}
