import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:organize/model/common/custom_colors.dart';

class CustomColorsCollections{
  List<CustomColors> _colors = [
    CustomColors(color: Colors.grey, id: "grey"),
    CustomColors(color: Colors.green, id: "green"),
    CustomColors(color: Colors.pink, id: "pink"),
    CustomColors(color: Colors.orange, id: "orange"),
    CustomColors(color: Colors.blue, id: "blue"),
    CustomColors(color: Colors.indigo, id: "indigo"),
  ];

  UnmodifiableListView get colors => UnmodifiableListView(_colors);

  CustomColors getColorById(String id){
    return _colors.firstWhere((color) => color.id == id);
  }
}