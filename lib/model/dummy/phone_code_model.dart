import 'package:flutter/material.dart';

class PhoneCode {
  final String name;
  final String code;
  final Image flag;

  PhoneCode({required this.name, required this.code, required this.flag});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PhoneCode &&
        other.name == name &&
        other.code == code &&
        other.flag == flag;
  }

  @override
  int get hashCode => name.hashCode ^ code.hashCode ^ flag.hashCode;
}
