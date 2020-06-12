import 'dart:ui';
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
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (OverscrollIndicatorNotification overScroll) {
                  overScroll.disallowGlow();
                  return false;
                },
                child: buildListView(),
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text('Expanded 2')),
            )
          ],
        ),
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

ListView buildListView() {
  return ListView(
    scrollDirection: Axis.horizontal,
    children: <Widget>[
      shopCard(Colors.orange[400], 'Chips'),
      shopCard(Colors.amber[400], 'Sensors'),
      shopCard(Colors.deepOrange[400], 'Cables'),
    ],
  );
}

Widget shopCard(Color color, String title) {
  return Align(
    alignment: Alignment.center,
    child: SizedBox(
      height: 70,
      width: 150,
      child: Card(
        color: color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ListTile(
              trailing: Icon(Icons.arrow_drop_down),
              title: FittedBox(
                child: Text(
                  title,
                  style: TextStyle(fontFamily: 'SpaceMono'),
                ),
              ),
              onTap: () {},
            ),
          ],
        ),
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
