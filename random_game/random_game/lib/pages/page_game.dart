import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:random_game/components/oo_elevated_button.dart';

import '../components/card_user_list.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  List<List<int>> numberList = [];
  int index = 0;

  @override
  Widget build(BuildContext context) {

    for (int i = 0; i < 2; i++) {
      numberList.add(<int>[]);
    }

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
            Text(
              '$numberList',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            _buildGetNumberButton(),
            _buildResultButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildGetNumberButton() {
    return OoElevatedButton(
        buttonPressed: () {
          setState(() {
            var rnd = Random().nextInt(100) + 1;
            numberList[index].add(rnd);
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        UserListCard(
          userName: 'user1',
          onTap: ()=>_resetNumber(0),
        ),
        UserListCard(
          userName: 'user2',
          onTap: ()=>_resetNumber(1),
        ),
      ],
    );
  }

  void _resetNumber(int index) {
    setState(() {
      numberList[index].clear();
    });
  }

  List<List<int>> getResult() {
    numberList.sort();
    return numberList;
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