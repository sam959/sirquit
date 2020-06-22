import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sirquit/src/navigator/navigator.dart';

class PersistentAppBar extends StatelessWidget {
  final String title;

  PersistentAppBar(this.title);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.home),
          onPressed: () {
            navigateTo(kHome, context);
          },
        )
      ],
    );
  }
}
