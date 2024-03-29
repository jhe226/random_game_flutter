import 'dart:math';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:random_game/components/oo_elevated_button.dart';
import 'package:collection/collection.dart';

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
          return RadioButtonCustom(
            controller: widget._controller,
            buttonTitle: widget.scoreList[position].userName,
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
      child: Text(
        '${selectedModel?.score ?? 0}',
        style: Theme.of(context).textTheme.headlineMedium,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildGetNumberButton() {
    return OoElevatedButton(
        buttonPressed: () {
          setState(() {
            int rnd = Random().nextInt(100) + 1;
            selectedModel?.score = rnd;
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

  List<String> getResult() {
    var scoreList =
        widget.scoreList.map((e) => e.score).toList().where((element) => false);
    var wonUser = widget.scoreList
        .where((element) => element.score == scoreList.max)
        .toList();

    return wonUser.map((e) => '1위\n${e.userName}\n${e.score}점').toList();
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
          Column(
            children: getResult()
                .map(
                  (e) => Text(
                    e,
                    textAlign: TextAlign.center,
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
