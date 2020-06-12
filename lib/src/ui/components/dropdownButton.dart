import 'package:flutter/material.dart';

DropdownButton dropdownButton(List<String> items) {
  var itemsList = items.map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    );
  }).toList();

  return DropdownButton(
    value: itemsList.first.value,
    icon: Icon(Icons.arrow_downward),
    iconSize: 15,
    elevation: 16,
    style: TextStyle(color: Colors.deepPurple),
    underline: Container(
      height: 2,
      color: Colors.deepPurpleAccent,
    ),
    items: itemsList,
    onChanged: (value) {},
  );
}
