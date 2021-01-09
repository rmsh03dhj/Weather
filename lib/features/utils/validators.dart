import 'package:flutter/material.dart';

class Validators {
  static FormFieldValidator required({String errorText = "Required."}) {
    return (value) {
      if (value == null ||
          ((value is Iterable || value is String || value is Map) && value.length == 0)) {
        return errorText;
      }
      return null;
    };
  }
}
