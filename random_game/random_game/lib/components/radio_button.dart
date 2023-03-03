import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:random_game/components/radio_controller.dart';

class RadioButtonCustom extends StatelessWidget {
  final RadioGroupController controller;
  final String userName;
  final int index;
  final VoidCallback onEvent;

  const RadioButtonCustom({
    super.key,
    required this.controller,
    required this.userName,
    required this.index,
    required this.onEvent,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, value, child) {
        return Container(
          width: 60.w,
          height: 60.w,
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
                color: (index == value) ? Colors.pink : Colors.black12,
                width: 1.w),
            borderRadius: BorderRadius.circular(15),
          ),
          child: ElevatedButton(
            onPressed: () {
              controller.setSelected(index);
              onEvent();
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              shadowColor: Colors.transparent,
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: Text(
              userName,
              style: TextStyle(
                color: (index == value) ? Colors.pink : Colors.grey,
                fontSize: 15.sp,
              ),
            ),
          ),
        );
      },
    );
  }
}
