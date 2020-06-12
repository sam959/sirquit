import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sirquit/src/ui/components/drawerMenu.dart';
import 'package:sirquit/src/ui/components/persistentAppBar.dart';

class Converters extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PersistentAppBar('Converters').build(context),
      drawer: DrawerMenu(),
    );
  }
}
