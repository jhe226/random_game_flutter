import 'package:flutter/material.dart';

class RadioGroupController extends ValueNotifier<int> {
  RadioGroupController(value) : super(value);

  void setSelected(int index) {
    value = index;
  }
}
