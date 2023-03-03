import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:random_game/components/radio_controller.dart';

class RadioButtonCustom extends StatelessWidget {
  final RadioGroupController controller;
  final String userName;
  final int index;
  final FocusNode? node;
  final VoidCallback onEvent;

  const RadioButtonCustom({
    super.key,
    required this.controller,
    required this.userName,
    required this.index,
    required this.onEvent,
    this.node,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, value, child) {
        return Container(
          width: 60.w,
          height: 60.w,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
                color: (index == value) ? Colors.pink : Colors.black12,
                width: 1.5),
            borderRadius: BorderRadius.circular(4),
          ),
          child: ElevatedButton(
            onPressed: () {
              node?.unfocus();
              controller.setSelected(index);
              onEvent;
            },
            style: ElevatedButton.styleFrom(
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: Text(
              userName,
              style: TextStyle(
                color: (index == value) ? Colors.pink : Colors.grey,
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
              ),
            ),
          ),
        );
      },
    );
  }
}
