import 'package:flutter/material.dart';
import 'package:bonnie_invest/asset.dart';
class SearchBarDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SearchBarDemoState();
}
class SearchBarDemoState extends State<SearchBarDemo> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        color: Colors.blue,
        height: 80.0,
        //alignment: Alignment.center,
        child: new Padding(
          padding: new EdgeInsets.only(top: 0.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Icon(Icons.ac_unit),
              //new Padding(padding: new EdgeInsets.only(left: 1.0)),
              new Container(
                color: Colors.blue,
                height: 35.0,
                width: 300.0,
                child: new Material(
                  color: Colors.white70,
                  borderRadius: new BorderRadius.horizontal(
                    left: new Radius.circular(20.0),
                    right: new Radius.circular(20.0)
                  ),
                  child: new Padding(
                    padding: new EdgeInsets.only(right: 5.0),
                    child: new Row(
                      children: <Widget>[
                        new Padding(padding: new EdgeInsets.only(left: 5.0)),
                        new Icon(Icons.search,color: const Color(0xFF616161)),
                        new Padding(padding: new EdgeInsets.only(left: 3.0)),
                        new Flexible(child: new TextField(
                          maxLines: 1,
                          style: new TextStyle(
                            color: const Color(0xFF616161),
                            fontSize: 14.0
                          ),
                          decoration: new InputDecoration.collapsed(
                              hintText: "请输入关键字"),
                          onTap: () => showSearch(context: context, delegate: SearchBarDelegate()) ,
                        ))
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      
      

//      appBar: AppBar(
//      //  title: Text('SearchBarDemo'),
//        actions: <Widget>[
//          IconButton(
//            icon: Icon(Icons.search),
//            onPressed: ()=>
//            showSearch(context: context, delegate: SearchBarDelegate())),
//
//        ],
//      ),
    );
  }
}
class SearchBarDelegate extends SearchDelegate<String>{
  @override
  List<Widget> buildActions(BuildContext context){
    return [IconButton(icon:Icon(Icons.clear),onPressed: ()=>query ="")];
  }
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () => close(context, null));
  }
  @override
  Widget buildResults(BuildContext context) {
    return Center(child: Container(
      width: 100.0,
      height: 100.0,
      child: Card(
        color: Colors.redAccent,
        child: Center(
          child: Text(query),
        ),
      ),
    ),);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? recentSuggest
        : searchList.where((input) => input.startsWith(query)).toList();
    return ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context, index) => ListTile(

          onTap: (){showResults(context);},

          title: RichText(
              text: TextSpan(
                  text: suggestionList[index].substring(0, query.length),
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                        text: suggestionList[index].substring(query.length),
                        style: TextStyle(color: Colors.grey))
                  ])),
        ));
  }

}