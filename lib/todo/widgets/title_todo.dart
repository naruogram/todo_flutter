import 'package:flutter/material.dart';

class TodoTitle extends StatelessWidget {
  const TodoTitle({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return const Text(
      "ToDoリスト",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 50,
        fontWeight: FontWeight.w100,
        fontFamily: 'Helvetica Neue',
      ),
    );
  }
}