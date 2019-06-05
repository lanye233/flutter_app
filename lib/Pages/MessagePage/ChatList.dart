import 'package:flutter/material.dart';
import 'package:bonnie_invest/Pages/MessagePage/MsgPage.dart';
class ChatList extends StatelessWidget {
  @override

  Widget build (BuildContext context) {
    return Scaffold(
      appBar:new AppBar(
        title: new Text(""),
      ),
      body: new ListView(
        children: <Widget>[
          new ListTile(
            leading: Icon(Icons.ac_unit),
            title: new Text("lanye"),
            onTap: (){
              Navigator.of(context)
                  .push(new MaterialPageRoute(builder: (context){
                return new MsgScreen();
              }));
            },
          )
        ],
      ),
    );
  }
}