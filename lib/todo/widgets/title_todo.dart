import 'package:flutter/material.dart';

class BasicTitle extends StatelessWidget {
  const BasicTitle({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return const Text(
      "ToDoリスト",
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Color.fromARGB(38, 47, 47, 247),
        fontSize: 100,
        fontWeight: FontWeight.w100,
        fontFamily: 'Helvetica Neue',
      ),
    );
  }
}