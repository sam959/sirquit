import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sirquit/src/ui/components/drawerMenu.dart';
import 'package:sirquit/src/ui/components/persistentAppBar.dart';

class Tutorials extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PersistentAppBar("Tutorials").build(context),
      drawer: DrawerMenu(),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}
