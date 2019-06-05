import 'package:flutter/material.dart';
import 'package:bonnie_invest/Pages/ItemPage/ItemJump.dart';
import 'package:bonnie_invest/model/DatabaseHelper.dart';
import 'package:bonnie_invest/model/Item.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:bonnie_invest/utils/OsApplication.dart';
import 'package:bonnie_invest/utils/Event/EditItemEvent.dart';
import 'package:bonnie_invest/Pages/ItemPage/ItemInfo.dart';

class MusicItem extends StatefulWidget {
  MusicItemState createState() => MusicItemState();
}
class MusicItemState extends State<MusicItem> {
  Item item;
  var db = new DatabaseHelper();
  List<Item> _datas = new List();
  var _titleController = new TextEditingController();
  var _wordsController = new TextEditingController();
  var _moneyController = new TextEditingController();
  var _beginController = new TextEditingController();
  var _overController = new TextEditingController();
  var cityName;
  var leftRes = new TextStyle(fontSize: 16.0,color: Colors.black);
  var hintRes = new TextStyle(fontSize: 15.0,color: Color(0xff969696));

//  final formats = {
//  //  InputType.date:DateFormat("yyyy - mm - dd"),
//    InputType.both: DateFormat("EEEE, MMMM d, yyyy 'at' h:mma"),
//    InputType.date: DateFormat('yyyy-MM-dd'),
//    InputType.time: DateFormat("HH:mm"),
//  } ;

  var date = new DateFormat('yyyy-MM-dd');
  
  InputType inputType = InputType.date;
  bool editable = true;
  DateTime _dateTime = DateTime.now();
  String year = DateTime.now().year.toString();

  DateTime date1 = DateTime.now();
  DateTime date2 = DateTime.now();
 

  //保存项目信息
  Future<Null> _save() async {

//    item.title = _titleController.text.toString();
//    item.words = _wordsController.text.toString();
//    item.money = _moneyController.text.toString();
//    item.begin = date1.toString().substring(0,10);
//    item.over = date2.toString().substring(0,10);
    String title = _titleController.text.toString();
    String words = _wordsController.text.toString();
    String money = _moneyController.text.toString();
    String begin = date1.toString().substring(0,10);
    String over = date2.toString().substring(0,10);

    Item item = new Item(title, words , begin, over, money);
    item.title = title;
    item.words = words;
    item.money = money;
    item.begin = begin;
    item.over = over;
    await db.saveItem(item);
    item.addItem(title, words, begin, over, money);
    OsApplication.eventBus.fire(new EditItemEvent(title, words, money, begin, over));
//    OsApplication.eventBus2.fire(new EditItemEvent(title, words, money, begin, over));
    _query();
    print("存储项目信息成功+$title");
  }
  //查询项目信息
  Future<Null> _query() async{
    _datas.clear();
    List datas = await db.getTotalLists('item');
    if(datas.length > 0) {
      datas.forEach((item){
        Item dataListBean = Item.fromMap(item);
        _datas.add(dataListBean);
      });
    }
    setState(() {

    });
    print(datas);
  }

  Future<Null> _beginDate(BuildContext context) async {
    final DateTime _picked = await showDatePicker(

      context: context,
      initialDate: date1, // 不能传入null
      firstDate: new DateTime.now().subtract(new Duration(days: 30)),
      lastDate: new DateTime.now().add(new Duration(days: 30)),
    );

    if (_picked != null) {
      print(_picked);
      setState(() {
        date1 = _picked;
      });
    }
  }
  Future<Null> _overDate(BuildContext context) async {
    final DateTime _picked1 = await showDatePicker(
      context: context,
      initialDate: date2, // 不能传入null
      firstDate: new DateTime.now().subtract(new Duration(days: 30)),
      lastDate: new DateTime.now().add(new Duration(days: 30)),
    );

    if (_picked1 != null) {
      print(_picked1);
      setState(() {
        date2 = _picked1;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("创建相关项目"),
      ),
      body: Form(child: Container(
        child:
        //Date(),

        ListView(
          children: <Widget>[
            title(),
            divider(),
            words(),
            divider(),
            a(),
         //   hhh(),
            b(),
            c(),
           // Date(),
          //  d(),
            button()

          ],
        ),


      )),
    );
  }

  TextField title(){
    return TextField(
      style: TextStyle(fontSize: 20.0),
      maxLength: 26,
      maxLines: 1,
      controller: _titleController,
      decoration: InputDecoration(
        hintText: "请输入项目标题，最多26个字",
        border: InputBorder.none,
      ),
    );
  }
  TextField words(){
    return TextField(
      style: TextStyle(fontSize: 15.0),
      maxLength: 120,
      maxLines: 10,
      controller: _wordsController,
      decoration: InputDecoration(
        hintText: "请输入项目简介，最多120个字",
        border: InputBorder.none,
      ),
    );
  }
  //目标金额
  Widget a(){
    return Padding(
      padding: new EdgeInsets.only(left: 10.0,right: 10.0),
      child: new Row(
        children: <Widget>[
          new Expanded(child: new Container(
            child: new Text('目标金额',style: leftRes,),
            alignment: Alignment.centerLeft,
            height: 50.0,
          ),
          ),
          new Expanded(flex:2,child: new Padding(
            padding: new EdgeInsets.only(left: 6.0,right: 6.0),
            child: new TextField(
              style: hintRes,
              maxLines: 1,
              controller: _moneyController,
              decoration: InputDecoration.collapsed(hintText: '￥2元起，项目审核后不可更改'),
              obscureText: false,
            ),
          )),
        ],
      ),
    );
  }
  //开始时间

  Widget Date(){
    return Padding(
      padding:const EdgeInsets.only(left: 10.0,right: 10.0),
      child: ListView(
        children: <Widget>[
          Text('Format:"${inputType}"'),
          DateTimePickerFormField(
            inputType: inputType,
            format: date,
            editable: editable,
            decoration: InputDecoration(
              labelText: '开始时间',hasFloatingPlaceholder: false
            ),
            onChanged: (dt) => setState(()=> _dateTime = dt),
          ),
          Text('Date value: $_dateTime'),
          SizedBox(height: 16.0),
          CheckboxListTile(
            title: Text('Date picker'),
            value: inputType != InputType.time,
            onChanged: (value) => updateInputType(date: value),
          ),
          CheckboxListTile(
            title: Text('Time picker'),
            value: inputType != InputType.date,
            onChanged: (value) => updateInputType(time: value),
          ),
          CheckboxListTile(
            title: Text('Editable'),
            value: editable,
            onChanged: (value) => setState(() => editable = value),
          ),

        ],
      ),
    );
  }

  Widget hhh(){
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: new Row(
        children: <Widget>[
          DateTimePickerFormField(
            inputType: inputType,
            format: date,
            editable: editable,
            decoration: InputDecoration(
                labelText: 'Date/Time', hasFloatingPlaceholder: false),
            onChanged: (dt) => setState(() => _dateTime = dt),
          ),

        ],
      ),
    );

  }
  void updateInputType({bool date, bool time}) {
    date = date ?? inputType != InputType.time;
    time = time ?? inputType != InputType.date;
    setState(() => inputType =
    date ? time ? InputType.both : InputType.date : InputType.time);
  }

  Widget b() {
    return Padding(
      padding: new EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
      child: new Row(
        children: <Widget>[
          new Expanded(child: new Container(
            child: new Text('开始时间',style: leftRes,),
            alignment: Alignment.centerLeft,
            height: 50.0,
          )),
          new Expanded(child: new Padding(
            padding:const EdgeInsets.all(0.0),
            child:  DateTimePickerFormField(
              inputType: inputType,
              format: date,
              editable: editable,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                border: InputBorder.none,
                  labelText: '开始时间',hasFloatingPlaceholder: false
              ),
              onChanged: (dt) => setState(()=> _dateTime = dt),
            ),
          )),
        ],
      ),
    );
  }
  Widget c(){
    return Padding(
      padding: new EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
      child: new Row(
        children: <Widget>[
          new Expanded(child: new Container(
            child: new Text('结束时间',style: leftRes,),
            alignment: Alignment.centerLeft,
            height: 50.0,
          )),

          new Expanded(child: new Padding(
            padding:const EdgeInsets.all(0.0),
            child:  DateTimePickerFormField(
              inputType: inputType,
              format: date,
              editable: editable,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: '结束时间',hasFloatingPlaceholder: false
              ),
              onChanged: (dt1) => setState(()=> date2 = dt1),
            ),
          )),

        ],
      ),
    );
  }
  Widget d(){
    return Padding(
      padding: new EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
      child: new Row(
        children: <Widget>[
          new Expanded(child: new Container(
            child: new Text('项目位置',style: leftRes,),
            alignment: Alignment.centerLeft,
            height: 50.0,
          )),
          new Expanded(flex:2,child: new Padding(
            padding: new EdgeInsets.only(left: 6.0,right: 6.0),
            child: new TextField(
              style: hintRes,
              maxLines: 1,
              controller: _beginController,
              decoration: InputDecoration.collapsed(hintText: '请选择项目位置'),
              obscureText: false,
            ),
          )),
          new Expanded(child: new Padding(
            padding: new EdgeInsets.only(right: 5.0),
            child: new InkWell(
              onTap: (){

              },
              child: new Icon(Icons.arrow_drop_down),
            ),
          )),
        ],
      ),
    );
  }

  Widget button(){
    return Container(
      padding: const EdgeInsets.all(5.0),
      color: Colors.blue,
      child: new InkWell(
        onTap: (){
          _save();
          print('chuangjian');
          Navigator.of(context)
              .push(new MaterialPageRoute(builder: (context){
                return new ItemJump();
          }));
        },
        child: Text("创建项目",
          style: new TextStyle(
              fontSize: 25.0,
              color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      )
    );
  }

  Divider divider(){
    return Divider(
      height: 1.0,
      color: Colors.grey,
    );
  }
}