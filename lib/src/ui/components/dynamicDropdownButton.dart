import 'package:flutter/material.dart';
import 'package:sirquit/src/sections/calculator/bloc/lp_calculator_states.dart';

Widget dynamicDropdownButton(ValueNotifier<bool> isEnabled, List<String> items,
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
      valueListenable: isEnabled,
      builder: (BuildContext context, isEnabled, Widget child) {
        print('Dropdown menu $isEnabled');
        return DropdownValues(isEnabled ? itemsList : null, onChanged);
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
    dropdownValue = itemsList?.first?.value;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: dropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 15,
      elevation: 16,
      style: TextStyle(
          color: Colors.deepOrange, fontSize: 15, fontWeight: FontWeight.bold),
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
