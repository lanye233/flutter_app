import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class  TestPage extends StatelessWidget {
  final _userNameController = new TextEditingController();
  final _userPwdController = new TextEditingController();

  Future<String> get _dbPath async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "Bonnie.db");

    return path;
  }

  Future<Database> get _localFile async {
    final path = await _dbPath;
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute(
              "CREATE TABLE lanye (id INTEGER PRIMARY KEY, name TEXT,password TEXT)");
        });
    return database;
  }

  Future<int> saveName(String name) async {
    final db = await _localFile;
    return db.transaction((trx){
      trx.rawInsert( 'INSERT INTO lanye(name) VALUES("$name")');
    });
  }
  Future<int> savePwd(String pwd) async {
    final db = await _localFile;
    return db.transaction((trx){
      trx.rawInsert( 'INSERT INTO lanye(password) VALUES("$pwd")');
    });
  }
  Future<List<Map>> get() async {
    final db = await _localFile;
    List<Map> list=    await db.rawQuery('SELECT * FROM lanye');
    return list;
  }
  @override
  Widget build(BuildContext context) {

    return new Builder(builder: (BuildContext context) {
      return new Scaffold(
        appBar: new AppBar(
          title: new Text("FileOperator"),
        ),
        body: new Center(
          child: new Builder(builder: (BuildContext context) {
            return new Column(
              children: <Widget>[
                new TextField(
                  controller: _userNameController,
                  decoration: new InputDecoration(
                      contentPadding: const EdgeInsets.only(top: 10.0),
                      icon: new Icon(Icons.perm_identity),
                      labelText: "请输入用户名",
                      helperText: "注册时填写的名字"),
                ),
                new TextField(
                  controller: _userPwdController,
                  decoration: new InputDecoration(
                      contentPadding: const EdgeInsets.only(top: 10.0),
                      icon: new Icon(Icons.perm_identity),
                      labelText: "请输入密码",
                      helperText: "注册时填写的密码"),
                ),
                RaisedButton(
                    color: Colors.blueAccent,
                    child: Text("存储"),
                    onPressed: () {
                      saveName(_userNameController.text.toString());
                      savePwd(_userPwdController.text.toString());
                      Scaffold.of(context).showSnackBar(
                          new SnackBar(content: new Text("数据存储成功")));
                    }),
                RaisedButton(
                    color: Colors.greenAccent,
                    child: Text("获取"),
                    onPressed: () {
                      Future<List<Map>> userName = get();
                      userName.then((List<Map> userNames) {
                        Scaffold.of(context).showSnackBar(
                            new SnackBar(content: Text("数据获取成功：$userNames")));
                      });
                    }),
                RaisedButton(
                  color: Colors.yellow,
                  child: Text("地址"),

                ),
              ],
            );
          }),
        ),
      );
    });
  }
}