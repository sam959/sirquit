import 'package:flutter/material.dart';

Widget dynamicDropdownButton(ValueNotifier<bool> isVisible, List<String> items,
    Function(String) onChanged) {
  var itemsList = items
      .map<DropdownMenuItem<String>>((String value) => DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
            ),
          ))
      .toList();

  return ValueListenableBuilder(
      valueListenable: isVisible,
      builder: (BuildContext context, isVisible, Widget child) {
        return Visibility(
          visible: isVisible,
          child: DropdownValues(itemsList, onChanged),
        );
      });
}

class DropdownValues extends StatefulWidget {
  DropdownValues(this.itemsList, this.onChanged);

  final List<DropdownMenuItem<String>> itemsList;
  final Function onChanged;

  @override
  _DropdownValuesState createState() =>
      _DropdownValuesState(itemsList, onChanged);
}

class _DropdownValuesState extends State<DropdownValues> {
  String dropdownValue;
  List<DropdownMenuItem<String>> itemsList;
  Function onChanged;

  _DropdownValuesState(this.itemsList, this.onChanged) {
    dropdownValue = itemsList.first.value;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: dropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 15,
      elevation: 16,
      style: TextStyle(color: Colors.deepOrange),
      underline: Container(
        height: 2,
        color: Colors.deepOrangeAccent,
      ),
      items: itemsList,
      onChanged: (value) {
        setState(() {
          dropdownValue = value;
        });
        onChanged(value);
      },
    );
  }
}
