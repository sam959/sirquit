import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sirquit/navigator/navigator.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          buildDrawerHeader(context),
          ListTile(
            title: Text(
              'Tutorials',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              openDrawerSection(kTutorials, context);
            },
          ),
          ListTile(
            title: Text(
              'Calculators',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              openDrawerSection(kCalculators, context);
            },
          ),
          ListTile(
            title: Text(
              'Converters',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              openDrawerSection(kConverters, context);
            },
          ),
        ],
      ),
    );
  }
}

DrawerHeader buildDrawerHeader(BuildContext context) {
  return DrawerHeader(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.white,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FittedBox(
                  child: Text(
                    'Samantha Lovisolo',
                    style: TextStyle(
                      fontFamily: 'BioRhyme',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Buyer lvl 2',
                  style: TextStyle(color: Colors.pink[50]),
                )
              ],
            ),
          ),
        )
      ],
    ),
    decoration: BoxDecoration(color: Theme.of(context).primaryColor),
  );
}

void showCalculatorsSection(BuildContext context) {
  navigateTo(kCalculators, context);
}
