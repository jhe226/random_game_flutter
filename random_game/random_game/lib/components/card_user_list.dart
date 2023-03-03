import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserListCard extends StatelessWidget {
  const UserListCard({required this.userName, super.key});

  final String userName;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60.w,
      height: 60.w,
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(width: 1.w, color: Colors.grey),
      ),
      child: Column(
        children: [
          Icon(
            Icons.person_rounded,
            size: 24.w,
          ),
          SizedBox(height: 15.h),
          Text(
            userName,
            style: TextStyle(fontSize: 15.sp, color: Colors.grey[300]),
          ),
        ],
      ),
    );
  }
}
