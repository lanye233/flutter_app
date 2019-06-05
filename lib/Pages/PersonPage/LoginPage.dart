import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:bonnie_invest/Pages/PersonPage/MyPage.dart';
import 'package:groovin_material_icons/groovin_material_icons.dart';
import 'package:bonnie_invest/Pages/PersonPage/PersonPage.dart';
import 'package:bonnie_invest/model/DatabaseHelper.dart';
import 'package:bonnie_invest/model/User.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:bonnie_invest/utils/Event/LoginEvent.dart';
import 'package:bonnie_invest/utils/OsApplication.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _userNameController = new TextEditingController();
  final _userPwdController = new TextEditingController();
  bool _nameState, _pwdState = false;

  List<User> _datas = new List();
  var db = new DatabaseHelper();

  Future<Null> _refresh() async {
    _query();
  }
  //创建表
  Future<Null> _create() async {
    List datas = await db.getTotalLists('tableUser');
//    if(datas.length > 0) {
//      db.initDb();
//    }
    db.open();
    _query();
  }
  //添加用户名和密码
  Future<Null> _add() async{
    User user = new User();
    user.username = _userNameController.text.toString();
    user.password = _userPwdController.text.toString();
    await db.saveUser(user);
    _query();
    print("用户名：" + user.username +"," + "密码：" +user.password);
  }
  //删除，默认删除第一条数据
  Future<Null> _delete() async {
    String username = _userNameController.text.toString();
    db.deleteItem(username);
    _query();

  }
  //清空表数据
  Future<Null> _clear() async {
    List datas = await db.getTotalLists('TableUser');
    if (datas.length > 0) {
      db.clear();
    }
    _query();
  }
  //删除表
  Future<Null> _deleteTable() async {
    List datas = await db.getTotalLists('tableUser');
    if(datas.length >0 ) {
      db.deleteTable();
    }
    _query();
  }
//  //修改，默认修改第一条数据
//  Future<Null> _update() async{
//    List datas = await db.getTotalLists();
//    if(datas.length > 0) {
//      //修改第一条数据
//      User u = User.fromMap(datas[0]);
//      u.username = "";
//      db.updateItem(u);
//      _query();
//    }
//  }
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
  //关闭数据库
  Future<Null> _close() async {
    db.close();
  }

  void _checkName() {
    if(_userNameController.text.isNotEmpty) {
      _nameState = true;
      print("姓名：" + _userNameController.text.toString());
    }else {
      _nameState = false;
    }
  }
  //检查用户名与密码是否匹配，登录跳转
  Future<Null> _checkEqual(BuildContext context) async{
    String name = _userNameController.text.toString();
    String pwd = _userPwdController.text.toString();
    String P = "[{password:" + " " + pwd + "}]";
    String result = await db.getItem(name);
    User user = new User();
    _checkName();
    if(result != null && result == P && _nameState == true) {
      _pwdState =true;
      User user = new User();
      user.username = _userNameController.text.toString();
      user.password = _userPwdController.text.toString();
      OsApplication.eventBus.fire(new LoginEvent(user.username));
      Navigator.pop(context);
      print("匹配");
      _query();
    } else {
      _pwdState = false;
      print("不匹配");
      _query();
    }
    setState(() {
    });
  }

  void register() {
    if(_pwdState == true && _nameState == true) {
      User user = new User();
      OsApplication.eventBus.fire(new LoginEvent(user.username));

    }
  }

  @override

  final _formKey = GlobalKey<FormState>();
  Color _eyeColor;
  bool _isClickEye = false;
  String Username;
  String Password;


  @override
   Widget build(BuildContext context) {
    return new Builder(builder: (BuildContext context){
      return Scaffold(
          appBar: AppBar(title: Text('Login'),),
          body: Form(
            key: _formKey,
            child: new Builder(builder:(BuildContext context){
              return new ListView(
                children: <Widget>[
                  initTitle(),
                  initLoginName(),
                  SizedBox(height:30.0),
                  initLoginPWD(),
                  initForgetPwd(),
                  SizedBox(height:50.0),
                  initButton(context),
                  initRegister(),
                  SizedBox(height:80.0),
                  initBottomIcon()
                ],
              );
            })
          )
      );
    });

  }

  Padding initTitle(){
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Text('Login ',style: TextStyle(fontSize: 30.0,color: Colors.blue,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
    );
  }

  Widget initLoginName(){
    return Padding(
      padding: const EdgeInsets.only(left: 10.0,right: 10.0),
      child: TextFormField(
        scrollPadding: const EdgeInsets.all(5.0),
        controller: _userNameController,
        onSaved: (String value) => Username = value,
        maxLength: 11,
        decoration: InputDecoration(
          labelText: '用户名',
          suffixIcon: new IconButton(
              icon: new Icon(Icons.clear,color: Colors.black45,),
              onPressed: (){
                _userNameController.clear();
              })
        ),
      ),
//      validator: (String value){
//        var isPhone = RegExp("^1[3456789][0-9]{9}");
//        if(!isPhone.hasMatch(value)){
//          return '用户名格式不正确';
//        }
//      },
    );
  }

  Widget initLoginPWD(){
    return Padding(
      padding: const EdgeInsets.only(left: 10.0,right: 10.0),
      child: TextFormField(
        controller: _userPwdController,
        obscureText: _isClickEye,
        onSaved: (String value) => Password = value,
        validator: (String value){
          if(value.isEmpty){
            return '密码不能为空';
          }
        },
        decoration: InputDecoration(
          labelText: '密码',
          suffixIcon: IconButton(
              icon: Icon(Icons.remove_red_eye,color: _eyeColor),
              onPressed:(){
                setState(() {
                  _isClickEye = !_isClickEye;
                  _eyeColor = _isClickEye ? Colors.grey: Colors.blue;
                });
              }
          ),
        ),
      ),
    );
  }

  Padding initForgetPwd(){
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            child:Text('忘记密码？'),
            onTap: (){
              Fluttertoast.showToast(msg: "忘记密码");
            },
          )
      ),
    );
  }

  Widget initButton(BuildContext context){
    return Align(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(padding: const EdgeInsets.only(left:80.0)),
              RaisedButton(
                  color: Colors.blueAccent[100],
                  child: Text("注册"),
                  onPressed: () {
//                saveName(_userNameController.text.toString());
//                saveName(_userPwdController.text.toString());
                    _add();
                    Scaffold.of(context).showSnackBar(
                        new SnackBar(content: new Text("注册成功")));
                  }),
              Padding(padding: const EdgeInsets.only(left: 10.0)),
//              RaisedButton(
//                  color: Colors.greenAccent[100],
//                  child: Text("清空"),
//                  onPressed: () {
////                Future<List<Map>> userName = _get();
////                userName.then((List<Map> userNames) {
////                  Scaffold.of(context).showSnackBar(
////                      new SnackBar(content: Text("数据获取成功：$userNames")));
////                });
//                    // _query();
//                    _clear();
//                  }),
//              Padding(padding: const EdgeInsets.only(left: 10.0)),
//              RaisedButton(
//                color: Colors.orangeAccent[100],
//                child: Text("关闭"),
//                onPressed: (){
//                  _close();
//                },
//              ),
//            ],
//          ),
//          Row(
//            children: <Widget>[
//              Padding(padding: const EdgeInsets.all(10.0)),
//              RaisedButton(
//                color: Colors.yellow[200],
//                child: Text("删除"),
//                onPressed: (){
//                  _delete();
//                },
//              ),
//              Padding(padding: const EdgeInsets.only(left: 10.0)),
//              RaisedButton(
//                color: Colors.indigoAccent[100],
//                child: Text("创建"),
//                onPressed: (){
//                  _create();
//                },
//              ),
              Padding(padding: const EdgeInsets.only(left: 10.0)),
              RaisedButton(
                color: Colors.purple[100],
                child: Text("登录"),
                onPressed: (){
                  _checkEqual(context);

                },
              ),
            ],
          ),

       //   new Padding(padding: const EdgeInsets.only(top: 10.0)),


//          new SizedBox(
//            width: 270.0,
//            height: 50.0,
//            child: RaisedButton(
//              child: Text('登录',style: TextStyle(color: Colors.white),),
//              color: Colors.blueAccent,
//              onPressed: (){
//                saveName(_userNameController.text.toString());
//                savePwd(_userPwdController.text.toString());
//                Scaffold.of(context).showSnackBar(
//                    new SnackBar(content: Text("存储成功"))
//                );
//              },
//              shape: StadiumBorder(side: BorderSide(color: Colors.blueAccent)),
//            ),
//          ),

        ],


      ),
    );
  }


//  void insertUserInfo() async {
//    await userSqlite.openSqlite();
//    await userSqlite.insert(new User(7,Name,Pwd));
//    await userSqlite.close();
// //   Navigator.of(context).pushNamed("PersonPage");
//    Future future = Navigator.push(context, PageRouteBuilder(pageBuilder:
//    (BuildContext context,Animation<double> animation,
//    Animation<double> secondaryAnimation){
//      return PersonScreen();
//    }));
//  }

  Padding initRegister(){
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: GestureDetector(
        child:Align(
          alignment: Alignment.center,
          child: Text('没有账号？点击注册'),
        ),
        onTap: (){
//          CommonUtils.showToast(context, '点击注册');
        },
      ),
    );
  }

  Align initBottomIcon(){
    return Align(
        alignment: Alignment.center,
        child: Container(
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: IconButton(
                    icon: Icon(GroovinMaterialIcons.facebook,size: 30,color: Colors.blue),
                    onPressed: (){

                    }
                ),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                    icon: Icon(GroovinMaterialIcons.twitter,size: 30,color: Colors.blue,),
                    onPressed: (){

                    }
                ),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                    icon: Icon(GroovinMaterialIcons.google,size: 30,color: Colors.blue),
                    onPressed: (){

                    }
                ),
              ),
            ],
          ),
        )
    );
  }
}
