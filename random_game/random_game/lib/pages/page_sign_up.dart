import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:random_game/components/oo_elevated_button.dart';
import 'package:random_game/pages/page_game.dart';

import '../components/card_user_list.dart';
import '../components/user.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  List<User> userList = [];
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[300],
        title: const Text('RANDOM NUMBER GAME'),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Container(
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildUserListView(),
              _buildAddUserTextFormField(),
              _buildSignUpButton(),
              _buildStartButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserListView() {
    return Container(
      width: 360.w,
      height: 100.h,
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: userList.length,
        itemBuilder: (context, position) {
          return UserListCard(userName: userList[position].userName);
        },
      ),
    );
  }

  Widget _buildAddUserTextFormField() {
    return Container(
      width: 200.w,
      margin: EdgeInsets.only(bottom: 20.h),
      alignment: Alignment.center,
      child: TextFormField(
        decoration: InputDecoration(
          labelText: '참가자 이름',
          hintText: '참가자 이름을 입력하세요.',
          labelStyle: TextStyle(fontSize: 13.sp, color: Colors.pink),
          hintStyle: TextStyle(fontSize: 13.sp),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.pink, width: 1.w),
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
        cursorColor: Colors.pink,
        controller: _textController,
        keyboardType: TextInputType.text,
        maxLines: 1,
      ),
    );
  }

  Widget _buildSignUpButton() {
    return OoElevatedButton(
      buttonPressed: () {

      },
      buttonTitle: '참가자 등록하기',
    );
  }

  Widget _buildStartButton() {
    return OoElevatedButton(
      buttonPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const GamePage()),
        );
      },
      buttonTitle: '시작하기',
    );
  }
}
