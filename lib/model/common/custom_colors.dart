import 'package:flutter/material.dart';

class CustomColors{
  String id;
  Color color;
  bool isSelected;
  CustomColors({
    required  this.color,
    required this.id,
    this.isSelected = false
  });
}