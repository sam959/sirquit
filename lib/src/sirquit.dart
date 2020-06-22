import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sirquit/src/ui/components/drawerMenu.dart';
import 'package:sirquit/src/ui/components/persistentAppBar.dart';

class MyApp extends StatelessWidget {
  MyApp({this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PersistentAppBar(title).build(context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Flexible(
            fit: FlexFit.loose,
            child: buildListView(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
      ),
      drawer:
          DrawerMenu(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

ListView buildFittedListView() {
  return ListView(
    itemExtent: 150,
    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
    scrollDirection: Axis.horizontal,
    children: <Widget>[
      Card(
        color: Colors.blue,
        child: ListTile(
          title: Text('Test'),
          leading: Icon(Icons.restaurant_menu),
          onTap: () {},
        ),
      ),
      Card(
        color: Colors.orange,
        child: ListTile(
          title: Text('Test'),
          leading: Icon(Icons.filter_vintage),
        ),
      ),
      Card(
        color: Colors.red,
        child: ListTile(
          title: Text('Test'),
          leading: Icon(Icons.free_breakfast),
        ),
      ),
    ],
  );
}

Widget buildListView() {
  return SizedBox(
    height: 70,
    child: NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (OverscrollIndicatorNotification overScroll) {
        overScroll.disallowGlow();
        return false;
      },
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          buildCard(Colors.orange[400], 'Chips'),
          buildCard(Colors.amber[400], 'Sensors'),
          buildCard(Colors.deepOrange[400], 'Cables'),
        ],
      ),
    ),
  );
}

Widget buildCard(Color color, String title) {
  return SizedBox(
    width: 150,
    child: Card(
      color: color,
      child: ListTile(
        trailing: Icon(Icons.arrow_drop_down),
        title: FittedBox(
          child: Text(
            title,
            style: TextStyle(fontFamily: 'SpaceMono'),
          ),
        ),
        onTap: () {},
      ),
    ),
  );
  return ButtonTheme(
    minWidth: 150,
    height: 50,
    child: RaisedButton(
      color: color,
      onPressed: () {},
    ),
  );
}
