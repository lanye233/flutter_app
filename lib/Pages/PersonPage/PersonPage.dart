import 'package:flutter/material.dart';
import 'package:bonnie_invest/Pages/PersonPage/LoginPage.dart';
import 'package:bonnie_invest/Pages/PersonPage/UserInfoPage.dart';
import 'package:bonnie_invest/utils/cache/SpUtils.dart';
import 'package:bonnie_invest/model/User.dart';
import 'package:event_bus/event_bus.dart';
import 'package:bonnie_invest/utils/OsApplication.dart';
import 'package:bonnie_invest/utils/Event/LoginEvent.dart';
import 'package:bonnie_invest/utils/Event/OldNameEvent.dart';
import 'package:bonnie_invest/utils/Event/PersonInfoEvent.dart';
import 'package:bonnie_invest/Pages/ItemPage/ItemInfo.dart';
import 'package:bonnie_invest/Pages/ItemPage/ItemList.dart';
import 'package:bonnie_invest/model/DatabaseHelper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PersonScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PersonScreenState();
}
class PersonScreenState extends State<PersonScreen> {
  @override
  EventBus eventBus = new EventBus();

  static const double IMAGE_ICON_WIDTH = 30.0;
  static const double ARROW_ICON_WIDTH = 16.0;

  // var _image ='http://www.wanandroid.com/resources/image/pc/logo.png';
  //Image userAvatar = new Image(image: null,fit: BoxFit.cover,);
  var userAvatar;

  // Image userAvatar;
  var userName;
  String signature;
  String email;
  var titleTextStyle = new TextStyle(fontSize: 16.0);

  var rightArrowIcon = new Image.asset(
    'images/ic_arrow_right.png',
    width: ARROW_ICON_WIDTH,
    height: ARROW_ICON_WIDTH,
  );

  @override
  void initState() {
    super.initState();
    _getUserInfo();
    OsApplication.eventBus.on<PersonInfoEvent>().listen((event) {
      setState(() {
        if (event != null && event.username != null) {
          userName = event.username;
          userAvatar = event.url;
          signature = event.signature;
          email = event.email;
          //_image = event.url;
          print("修改监听成功");
        } else {
          userName = null;
          userAvatar = null;
          print("姓名为空");
          print(event.username);
          print(event);
        }
      });
    });
    OsApplication.eventBus.on<LoginEvent>().listen((event) {
      setState(() {
        if (event != null && event.username != null) {
          userName = event.username;
          userAvatar = File("http://www.wanandroid.com/resources/image/pc/logo.png");
          // userAvatar = Image.asset("images/zy.jpg");
          print("注册监听成功");
        } else {
          userName = null;
          userAvatar = null;
          print("姓名为空");
          print(event.username);
          print(event);
        }
      });
    });
  }


  Widget build(BuildContext context) {
    final Decoration decoration = BoxDecoration(
        border: Border(
            bottom: Divider.createBorderSide(context, width: 10.0)
        )
    );
    return La();
  }

  Widget La() {
    return CustomScrollView(reverse: false, shrinkWrap: false,
      slivers: <Widget>[
        new SliverAppBar(
          pinned: false,
          backgroundColor: Colors.blue,
          expandedHeight: 200.0,
          iconTheme: new IconThemeData(color: Colors.transparent),
          flexibleSpace: new InkWell(
              onTap: () {
                userAvatar == null ? _login() : _userDetail();
              },
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  userAvatar == null
                      ? new Image.asset(
                    "images/ic_avatar_default.png",
                    width: 60.0,
                    height: 60.0,
                  )
                      :

//                  new Container(
//                    width: 60.0,
//                    height: 60.0,
//                    child:
//                    CircleAvatar(
//                      child: userAvatar,
//                      radius: 50.0,
//                      //new Image.file(_image,fit: BoxFit.cover,)
//                      //Image.asset(userAvatar,fit: BoxFit.cover,),
//                    ),
//                  ),


                  new Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                      image: new DecorationImage(
                          image: new FileImage(userAvatar),
                          fit: BoxFit.cover
                      ),
                      border: new Border.all(
                          color: Colors.white, width: 2.0
                      ),
                    ),

//                    child: new InkWell(
//                      child: Image.file(userAvatar,fit: BoxFit.cover,),
//                    ),

                  ),

                  new Container(
                    margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                    child: new Text(
                      userName == null ? '点击头像登录' : userName,
                      style: new TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                  ),
                  new Container(
                    child: new Text(
                      signature == null ? '' : signature,
                      style: new TextStyle(color: Colors.white, fontSize: 10.0),
                    ),
                  )
                ],
              )
          ),
        ),
        new SliverList(
            delegate: new SliverChildListDelegate([
              a(),
         //     b(),
              c(),
              d(),
            ])),

      ],
    );
  }

  Widget a() {
    return new Container(
      decoration: new BoxDecoration(
          border: new Border(
              top: BorderSide(width: 10.0, color: Colors.grey[200]))
      ),
      alignment: Alignment.centerLeft,
      child: new InkWell(
//        onTap: (){
//
//        },
        child: new Column(
          children: <Widget>[
            new Padding(padding: const EdgeInsets.all(12.5),
              child: new InkWell(
                onTap: () {

                },
                child: new Row(
                  children: <Widget>[
                    new Text("全部订单", style: new TextStyle(fontSize: 20.0),),
                    new Icon(Icons.arrow_right)
                  ],
                ),
              ),
            ),
            new Padding(padding: const EdgeInsets.only(left: 40, bottom: 10.0),
              child: new Row(
                children: <Widget>[
                  new InkWell(
                    onTap: () {

                    },
                    child: new Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: new Column(
                        children: <Widget>[
                          new Icon(Icons.shopping_cart, size: 35.0,
                              color: Colors.grey),
                          new Text("待付款", style: new TextStyle(
                            fontSize: 15.0,
                          ),)
                        ],
                      ),
                    ),
                  ),
                  new InkWell(
                    onTap: () {

                    },
                    child: new Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: new Column(
                        children: <Widget>[
                          new Icon(Icons.account_balance_wallet, size: 35.0,
                              color: Colors.grey),
                          new Text("待发货", style: new TextStyle(
                            fontSize: 15.0,
                          ),)
                        ],
                      ),
                    ),
                  ),
                  new InkWell(
                    onTap: () {

                    },
                    child: new Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: new Column(
                        children: <Widget>[
                          new Icon(Icons.shop, size: 35.0, color: Colors.grey),
                          new Text("待收货", style: new TextStyle(
                            fontSize: 15.0,
                          ),)
                        ],
                      ),
                    ),
                  ),
                  new InkWell(
                    onTap: () {

                    },
                    child: new Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: new Column(
                        children: <Widget>[
                          new Icon(Icons.shopping_basket, size: 35.0,
                              color: Colors.grey),
                          new Text("已收货", style: new TextStyle(
                            fontSize: 15.0,
                          ),)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget b() {
    return Container(
      decoration: new BoxDecoration(
          border: new Border(
              top: BorderSide(width: 10.0, color: Colors.grey[200]))
      ),
      child: new InkWell(
        onTap: () {
          Navigator.of(context)
              .push(new MaterialPageRoute(builder: (context) {
            return new ItemInfo();
          }));
        },
        child: new Column(
          children: <Widget>[
            new Padding(padding: const EdgeInsets.only(left: 12.5, top: 5.0,bottom: 5.0),
              child: new InkWell(
                onTap: () {},
                child: new Row(
                  children: <Widget>[
                    new Text("我的云养计划", style: new TextStyle(fontSize: 15.0),),
                    new Icon(Icons.arrow_right)
                  ],
                ),
              ),
            ),
//            new Divider(
//              indent: 1.0,
//            ),
//            new Padding(padding: const EdgeInsets.only(left: 12.5),
//              child: new InkWell(
////              onTap: (){
////
////              },
//                child: new Row(
//                  children: <Widget>[
//
//                    new Image.asset("images/yyyy.jpg",
//                      width: 150.0,
//                      height: 100.0,
//                      fit: BoxFit.fill,
//                    ),
//                    new InkWell(
//                      onTap: () {
//
//                      },
//                      child: new Padding(
//                        padding: const EdgeInsets.only(left: 25.0),
//                        child: new Text("叶叶的画",
//                          style: new TextStyle(
//                              fontSize: 20.0
//                          ),),
//                      ),
//
//                    ),
//
//                  ],
//                ),
//              ),
//            )
          ],
        ),
      ),
    );
  }

  Widget c() {
    return Container(
      decoration: new BoxDecoration(
          border: new Border(
              top: BorderSide(width: 10.0, color: Colors.grey[200]))
      ),
      child: new Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10),
            child: new InkWell(
              onTap: () {
                Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
                  return new ItemList();
                }));
              },
              child: new Row(
                children: <Widget>[
                  new Text("发起的项目", style: new TextStyle(fontSize: 15.0),),
                  new Icon(Icons.arrow_right)
                ],
              ),
            ),
          ),
          new Divider(
            indent: 1.0,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10),
            child: new InkWell(
              onTap: () {},
              child: new Row(
                children: <Widget>[
                  new Text("支持的项目", style: new TextStyle(fontSize: 15.0),),
                  new Icon(Icons.arrow_right),
                ],
              ),
            ),
          ),
          new Divider(
            indent: 1.0,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, bottom: 10),
            child: new InkWell(
              onTap: () {},
              child: new Row(
                children: <Widget>[
                  new Text("看好的创意", style: new TextStyle(fontSize: 15.0),),
                  new Icon(Icons.arrow_right),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget d() {
    return Container(
      decoration: new BoxDecoration(
          border: new Border(
              top: BorderSide(width: 10.0, color: Colors.grey[200]))
      ),
      child: new Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10),
            child: new InkWell(
              onTap: () {},
              child: new Row(
                children: <Widget>[
                  new Text("设置", style: new TextStyle(fontSize: 15.0),),
                  new Icon(Icons.arrow_right),
                ],
              ),
            ),
          ),
          new Divider(
            indent: 1.0,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10),
            child: new InkWell(
              onTap: () {},
              child: new Row(
                children: <Widget>[
                  new Text("客服中心", style: new TextStyle(fontSize: 15.0),),
                  new Icon(Icons.arrow_right),
                ],
              ),
            ),
          ),
          new Divider(
            indent: 1.0,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, bottom: 10),
            child: new InkWell(
              onTap: () {},
              child: new Row(
                children: <Widget>[
                  new Text("建议与反馈", style: new TextStyle(fontSize: 15.0),),
                  new Icon(Icons.arrow_right),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  //构建布局
//  Widget register(){
//    return new CustomScrollView(reverse: false,shrinkWrap: false,slivers: <Widget>[
//      new SliverAppBar(
//        pinned: false,
//        backgroundColor: Colors.blue,
//        expandedHeight: 200.0,
//        iconTheme: new IconThemeData(color: Colors.transparent),
//        flexibleSpace: new InkWell(
//          onTap: (){
//            userAvatar == null ? _login(): _userDetail();
//          },
//            child: new Column(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                userAvatar == null
//                    ? new Image.asset(
//                  "images/ic_avatar_default.png",
//                  width: 60.0,
//                  height: 60.0,
//                )
//                    : new Container(
//                  width: 60.0,
//                    height: 60.0,
//                  decoration: new BoxDecoration(
//                    shape: BoxShape.circle,
//                    color: Colors.transparent,
//                    image: new DecorationImage(
//                        image: new NetworkImage(userAvatar),
//                        fit: BoxFit.cover),
//                    border: new Border.all(
//                      color: Colors.white,width: 2.0
//                    )
//                  ),
//                ),
//                new Container(
//                  margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
//                  child: new Text(
//                    userName == null ? '点击头像登录' : userName,
//                    style: new TextStyle(color: Colors.white,fontSize: 16.0),
//                  ),
//                )
//              ],
//            )
//        ),
//      ),
//      new SliverFixedExtentList(
//          delegate:
//              new SliverChildBuilderDelegate((BuildContext context,int index){
//                String title = titles[index];
//                return new Container(
//                  alignment: Alignment.centerLeft,
//                  child: new InkWell(
//                    onTap: (){
//
//                      print("this is the item of title");
//                    },
//                    child: new Column(
//                      children: <Widget>[
//                        new Padding(
//                            padding:const EdgeInsets.fromLTRB(12.5, 12.5, 12.5, 12.5),
//                        child: new Row(
//                          children: <Widget>[
//                            new Expanded(
//                                child: new Text(
//                                    title,
//                                    style: titleTextStyle,
//                                    )),
//                            rightArrowIcon
//                          ],
//                        ),),
//                        new Divider(
//                          height: 1.0,
//                        )
//
//                      ],
//                    ),
//                  ),
//                );
//              },childCount: titles.length) ,
//          itemExtent: 50.0)
//    ],
//
//    );
//  }

  _login() async {
    final result = await Navigator.of(context)
        .push(new MaterialPageRoute(builder: (context) {
      return new LoginPage();
    }));
    if (result != null && result == 'refresh') {
      _getUserInfo();
    }
  }

  _userDetail() {
    String oldName = userName;
    OsApplication.eventBus1.fire(new OldNameEvent(oldName));
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new UserInfoPage();
    }));
    print("旧名是：" + oldName);
  }

  _getUserInfo() async {
    SpUtils.getUserInfo().then((userInfoBean) {
      if (userInfoBean != null && userInfoBean.username != null) {
        setState(() {
          userName = userInfoBean.username;
          userAvatar = userInfoBean.url;
        });
      }
    });
  }

}


