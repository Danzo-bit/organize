
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryIcon extends StatelessWidget {
  final Color? color;
  final IconData icon;
  const CategoryIcon({
    super.key, 
    this.color,
    required this.icon
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(4),
        decoration:  BoxDecoration(
            color: color ?? CupertinoColors.activeBlue,
            shape: BoxShape.circle),
        child: Icon(
          icon,
          color: Colors.white,
          size: 18,
        ));
  }
}