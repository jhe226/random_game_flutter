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
              SizedBox(height: 10.h),
              _buildStartButton(),
              SizedBox(height: 10.h),
              _buildDeleteUserButton(),
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
          print('userList: ${userList[position].userName}');
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
        onPressed: () => (cnt < 4) ? _addUser() : {},
        style: ElevatedButton.styleFrom(
            backgroundColor: (cnt < 4) ? Colors.pink[300] : Colors.grey),
        child: Text(
          '참가자 등록하기',
          style: TextStyle(color: (cnt < 4) ? Colors.white : Colors.black26),
        ),
      ),
    );
  }

  void _addUser() {
    setState(() {
      cnt++;
      print('#############cnt: $cnt');
      while (cnt < 5) {
        userList.add(User(userName: 'User $cnt'));
        break;
      }
    });
  }

  Widget _buildDeleteUserButton() {
    return SizedBox(
      width: 125.w,
      height: 30.h,
      child: ElevatedButton(
        onPressed: () => (cnt > 0) ? _removeUser() : {},
        style: ElevatedButton.styleFrom(
            backgroundColor: (cnt > 0) ? Colors.pink[300] : Colors.grey),
        child: Text(
          '참가자 삭제하기',
          style: TextStyle(color: (cnt > 0) ? Colors.white : Colors.black26),
        ),
      ),
    );
  }

  void _removeUser() {
    setState(() {
      cnt--;
      while(cnt < 0) {
        userList.removeWhere((element) => userList[cnt].userName == 'User $cnt');
        break;
      }
      print('#############cnt: $cnt');
      print('#############userList: $userList');
    });
  }

  Widget _buildStartButton() {
    return ElevatedButton(
      onPressed: () => (cnt > 0)
          ? Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const GamePage()),
            )
          : {},
      style: ElevatedButton.styleFrom(
          backgroundColor:
              (cnt > 0) ? Colors.pink[300] : Colors.grey),
      child: Text(
        '시작하기',
        style: TextStyle(
            color: (cnt >0) ? Colors.white : Colors.black26),
      ),
    );
  }
}
