import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OoElevatedButton extends StatelessWidget {
  OoElevatedButton({required this.buttonPressed, required this.buttonTitle, super.key});

  VoidCallback buttonPressed;
  String buttonTitle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120.w,
      child: ElevatedButton(
        onPressed: buttonPressed,
        style: ElevatedButton.styleFrom(backgroundColor: Colors.pink[300]),
        child: Text(buttonTitle),
      ),
    );;
  }
}
