import 'package:flutter/material.dart';

class PhoneCode {
  final String office;
  final String code;
  final Image flag;

  PhoneCode({required this.office, required this.code, required this.flag});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PhoneCode &&
        other.office == office &&
        other.code == code &&
        other.flag == flag;
  }

  @override
  int get hashCode => office.hashCode ^ code.hashCode ^ flag.hashCode;
}
