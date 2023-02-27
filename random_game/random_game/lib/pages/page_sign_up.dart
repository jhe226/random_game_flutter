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
  int cnt = 0;

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


  Widget _buildSignUpButton() {
    return OoElevatedButton(
      buttonPressed: () {
        if(userList.length > 4) {
          return;
        } else {
          _addUser();
        }
      },
      buttonTitle: '참가자 등록하기',
    );
  }

  void _addUser() {
    setState(() {
      cnt++;
      for(int i = 0; i < cnt; i++) {
        userList.add(User(userName: 'User $cnt'));
      }
    });
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