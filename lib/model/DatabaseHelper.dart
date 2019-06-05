import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:bonnie_invest/model/User.dart';
import 'package:bonnie_invest/model/Item.dart';
import 'package:bonnie_invest/Pages/DynamicsPage/story_data.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  final String tableName = 'tableUser';
  final String ColumnId = 'id';
  final String ColumnName = 'username';
  final String ColumnPwd = 'password';
  static Database _db;

  DatabaseHelper.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }


  initDb() async {
    //获取数据库的路径
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath,'Bonnie_invest.db');
    //打开数据库
    var ourDb =await openDatabase(path,version: 1,onCreate: _onCreate);
    return ourDb;
  }
  //创建数据库1
  void _onCreate (Database db,int newVersion) async {
    await db.execute(
        'CREATE TABLE tableUser(id INTEGER PRIMARY KEY AUTOINCREMENT,username TEXT NOT NULL,password TEXT NOT NULL,url BLOB,signature TEXT,email TEXT)');
    await db.execute(
        'CREATE TABLE item(id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT NOT NULL,words TEXT NOT NULL,begin TEXT,over TEXT,money TEXT,type TEXT,url BLOB )');
    await db.execute(
        'CREATE TABLE dynamics(name TEXT NOT NULL,date TEXT,url BLOB NOT NULL,dynamics TEXT NOT NULL,images BLOB )');
    await db.execute(
        'CREATE TABLE story(id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT ,subTitle TEXT ,description TEXT  )');
    print("Table is created");
  }


//    Future<int> saveName(String Username) async{
//    final db =await _db;
//    return db.transaction((trx){
//      trx.rawInsert('INSERT INTO big(name) VALUES("$Username")');
//    });
//  }
//
//  Future<int> savePwd(String Password) async{
//    final db =await _db;
//    return db.transaction((trx){
//      trx.rawInsert('INSERT INTO big(password) VALUES("$Password")');
//    });
//  }

  //插入一条数据到item表
  Future<int> saveItem(Item item) async {
    var dbClient = await db;
    var result = await dbClient.insert("item", item.toMap());
    print(result.toString());
    return result;
  }

  Future<int> saveStory(Story story) async {
    var dbClient = await db;
    var result = await dbClient.insert("story", story.toMap());
    print(result.toString());
    return result;
  }
  //插入一条数据到user表
  Future<int> saveUser(User user) async {
    var dbClient =await db;
    var result = await dbClient.insert("tableUser", user.toMap());
    print(result.toString());
    return result;
  }
  //查询所有的数据
  Future<List> getTotalLists(String table) async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM $table");
    return result.toList();
  }
  //查询数量
  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(await dbClient.rawQuery(
        'SELECT COUNT(*) FROM $tableName'));
  }
  //按照ID查询
//  Future<User> getItem(int id) async {
//    var dbClient = await db;
//    var result = await dbClient.rawQuery(
//        "SELECT * FROM $tableName WHERE id = $id");
//    if (result.length > 0) {
//      return  User.fromMap(result.first);
//    }else{
//      return null;
//    }
//  }

  //获取密码
  Future<String> getItem(String name) async {
    var dbClient = await db;
    var result = await dbClient.rawQuery(
        "SELECT password FROM $tableName WHERE username = '$name'");
    print(result);
    if (result.length > 0) {
      return  result.toString();
    }else{
      return null;
    }
  }

  //按照姓名查询
  Future<String> queryPwd(name) async {
    var dbClient = await db;
    var result =  await dbClient.rawQuery(
        "SELECT $ColumnPwd FROM $tableName WHERE '$ColumnName' = '$name'");
    if(result != null) {
      return result.toString();
    }

  }
  //清空表数据
  Future<int> clear() async {
    var dbClient = await db;
    return await dbClient.delete(tableName);
  }
  //删除表
  Future<int> deleteTable() async{
    var dbClient = await db;
    var result = await dbClient.rawQuery("DROP TABLE $tableName");
}
  //根据name删除
  Future<String> deleteItem(String name) async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("DELETE FROM $tableName WHERE $ColumnName = '$name'");

    print("删除");
  }
  
//  Future<String> update(User user) async {
//    var dbClient = await db;
//    dbClient.update(tableName, user.toMap());
//  }
  //修改姓名
  Future<String> updateName (String name,String oldName) async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("UPDATE $tableName SET $ColumnName = '$name' WHERE $ColumnName = '$oldName'" );
    return result.toString();
//    return await dbClient.update("$tableName", user.toMap(),
//        where: "$ColumnName = ?", whereArgs: [user.username]);
  }
  Future<String> updateEmail (String email,String oldName) async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("UPDATE $tableName SET email = '$email' WHERE $ColumnName = '$oldName'");
    return result.toString();
  }
  Future<String> updateSignature (String signature,String oldName) async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("UPDATE $tableName SET signature = '$signature' WHERE $ColumnName = '$oldName'");
    return result.toString();
  }

//  void saveName(String Username) async{
//    var dbClient = await db;
//    return dbClient.execute("INSERT $Username INTO user(_user_name) ");
//  }

//  Future<int> savePwd(String Password) async{
//    var dbClient = await db;
//    return db.((trx){
//      trx.rawInsert('INSERT INTO user(pwd) VALUES("$Password")');
//    });
//  }

  //关闭数据库
  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }

  Future open() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath,'Bonnie_invest.db');
    //打开数据库
    var ourDb =await openDatabase(path,version: 1,onCreate: _onCreate);
    return ourDb;
  }
}