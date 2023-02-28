import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:random_game/components/oo_elevated_button.dart';

import '../components/card_user_list.dart';
import '../components/user.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  List<User> scoreList = [];
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[300],
        title: const Text('RANDOM NUMBER GAME'),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildUserList(),
            SizedBox(height: 30.h),
            const Text(
              'push the button',
            ),
            // _buildScore(),
            _buildGetNumberButton(),
            SizedBox(height: 10.h),
            _buildResultButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildScore() {
    return Container(
        width: 360.w,
        height: 40.h,
        alignment: Alignment.center,
        child: ListView.builder(
          itemBuilder: (context, index) => Text(
            '${scoreList[index].score}',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ));
  }

  Widget _buildGetNumberButton() {
    return OoElevatedButton(
        buttonPressed: () {
          setState(() {
            int rnd = Random().nextInt(100) + 1;
            scoreList.add(User(score: rnd));
          });
        },
        buttonTitle: '숫자 생성하기');
  }

  Widget _buildResultButton() {
    return OoElevatedButton(
        buttonPressed: () => showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                insetPadding: EdgeInsets.symmetric(vertical: 200.h),
                title: const Text('결과보기'),
                content: _showResult(),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ],
              ),
            ),
        buttonTitle: '결과 보기');
  }

  Widget _buildUserList() {
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
        itemCount: scoreList.length,
        itemBuilder: (context, position) {
          print('userList: ${scoreList[position].userName}');
          return UserListCard(userName: scoreList[position].userName);
        },
      ),
    );
  }

  void _resetNumber(int index) {
    setState(() {
      scoreList.clear();
    });
  }

  List<User> getResult() {
    scoreList.sort();
    return scoreList;
  }

  Widget _showResult() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          Text('${getResult()}'),
        ],
      ),
    );
  }
}
