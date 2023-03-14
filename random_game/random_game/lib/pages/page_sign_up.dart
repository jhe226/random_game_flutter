import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  final int _min = 1;
  final int _max = 4;

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
              SizedBox(height: 10.h),
              _buildStartButton(),
              SizedBox(height: 10.h),
              _buildDeleteUserButton(),
              SizedBox(height: 10.h),
              _buildResetButton(),
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
    return SizedBox(
      width: 125.w,
      height: 30.h,
      child: ElevatedButton(
        onPressed: userList.length < _max ? _addUser : null,
        style: ElevatedButton.styleFrom(
            backgroundColor: (userList.length < _max) ? Colors.pink[300] : Colors
                .grey),
        child: Text(
          '참가자 등록하기',
          style: TextStyle(
              color: (userList.length < _max) ? Colors.white : Colors.black26),
        ),
      ),
    );
  }

  void _addUser() {
    setState(() {
      if (userList.length < _max) {
        userList.add(User(userName: 'User ${userList.length + 1}', score: 0));
      }
    });
  }

  Widget _buildDeleteUserButton() {
    return SizedBox(
      width: 125.w,
      height: 30.h,
      child: ElevatedButton(
        onPressed: userList.isNotEmpty ? _removeUser : null,
        style: ElevatedButton.styleFrom(
            backgroundColor: (userList.isNotEmpty) ? Colors.pink[300] : Colors
                .grey),
        child: Text(
          '참가자 삭제하기',
          style: TextStyle(
              color: (userList.isNotEmpty) ? Colors.white : Colors.black26),
        ),
      ),
    );
  }

  void _removeUser() {
    setState(() {
      if (userList.isNotEmpty) {
        userList.removeLast();
      }

    });
  }

  Widget _buildStartButton() {
    return ElevatedButton(
      onPressed: _moveGamePage,
      style: ElevatedButton.styleFrom(
          backgroundColor:
          (userList.length > _min) ? Colors.pink[300] : Colors.grey),
      child: Text(
        '시작하기',
        style: TextStyle(
            color: (userList.length > _min) ? Colors.white : Colors.black26),
      ),
    );
  }

  void _moveGamePage() {
    if (userList.length > _min) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => GamePage(scoreList: userList)),
      );
    } else {
      return;
    }
  }

  Widget _buildResetButton() {
    return ElevatedButton(
      onPressed: _resetUser,
      style: ElevatedButton.styleFrom(
          backgroundColor:
          (userList.isNotEmpty) ? Colors.pink[300] : Colors.grey),
      child: Text(
        '초기화',
        style: TextStyle(
            color: (userList.length > _min) ? Colors.white : Colors.black26),
      ),
    );
  }

  void _resetUser() {
    setState(() {
      userList.clear();
    });
  }
}
