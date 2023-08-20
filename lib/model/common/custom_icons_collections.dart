import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:organize/model/common/custom_icons.dart';

class CustomIconsCollections {
  final List<CustomIcon> _icons = [
    CustomIcon(id: "plane", icon: Icons.airplanemode_active),
    CustomIcon(id: "cookies", icon: Icons.cookie),
    CustomIcon(id: "work", icon: Icons.work),
    CustomIcon(id: "snooze", icon: Icons.snooze),
    CustomIcon(id: "calendar", icon: Icons.calendar_month),
    CustomIcon(id: "telegram", icon: Icons.telegram),
    CustomIcon(id: "done", icon: Icons.done),
    CustomIcon(id: "bus", icon: Icons.bus_alert),
    CustomIcon(id: "energy", icon: Icons.energy_savings_leaf),
  ];

  UnmodifiableListView get icons => UnmodifiableListView(_icons);

  CustomIcon getIconById(String id) {
    return _icons.firstWhere((element) => element.id == id);
  }
}
