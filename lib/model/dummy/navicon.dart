import 'package:flutter/material.dart';

class NavIcon {
  final IconData icon;
  final IconData? activeIcon;
  final String title;

  const NavIcon({
    required this.icon,
    this.activeIcon,
    required this.title,
  });
}
