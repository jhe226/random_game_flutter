import 'dart:math';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:random_game/components/oo_elevated_button.dart';

import '../components/radio_button.dart';
import '../components/radio_controller.dart';
import '../components/user.dart';

class GamePage extends StatefulWidget {
  List<User> scoreList;

  GamePage({super.key, required this.scoreList});

  final RadioGroupController _controller = RadioGroupController(-1);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  User? selectedModel;

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildUserList(),
            SizedBox(height: 20.h),
            const Text('push the button'),
            SizedBox(height: 10.h),
            _buildScore(),
            SizedBox(height: 5.h),
            _buildGetNumberButton(),
            SizedBox(height: 10.h),
            _buildResultButton(),
          ],
        ),
      ),
    );
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
        itemCount: widget.scoreList.length,
        itemBuilder: (context, position) {
          print('##########=userList: ${widget.scoreList[position].userName}');
          return RadioButtonCustom(
            controller: widget._controller,
            userName: widget.scoreList[position].userName,
            index: position,
            onEvent: () {
              setState(() {
                selectedModel = widget.scoreList[position];
              });
            },
          );
        },
      ),
    );
  }

  Widget _buildScore() {
    return Container(
        width: 360.w,
        height: 40.h,
        alignment: Alignment.center,
        child: ListView.builder(
          itemCount: widget.scoreList.length,
          itemBuilder: (context, index) => Text(
            '${selectedModel?.score ?? 0}',
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
        ));
  }

  Widget _buildGetNumberButton() {
    return OoElevatedButton(
        buttonPressed: () {
          setState(() {
            int rnd = Random().nextInt(100) + 1;
            selectedModel?.score = rnd;
            print('###############=user: ${selectedModel?.userName}');
            print('###############=score: ${selectedModel?.score}');
          });
        },
        buttonTitle: '숫자 생성하기');
  }

  Widget _buildResultButton() {
    return OoElevatedButton(
        buttonPressed: () => showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                insetPadding: EdgeInsets.symmetric(vertical: 200.h),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 60.h, horizontal: 20.w),
                content: _showResult(),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'OK',
                      style: TextStyle(color: Colors.pink),
                    ),
                  ),
                ],
              ),
            ),
        buttonTitle: '결과 보기');
  }

  String getResult() {
    widget.scoreList.sort((a, b) => a.score.compareTo(b.score));
    return '1위\n${widget.scoreList.reversed.first.userName}\n${widget.scoreList.reversed.first.score}점';
  }

  Widget _showResult() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          Text(
            '결과',
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 15.h),
          Text(
            getResult(),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
