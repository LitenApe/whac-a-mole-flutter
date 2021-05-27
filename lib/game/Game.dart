import 'dart:math';

import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  Game({Key key}) : super(key: key);

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  bool _running = false;
  int _active = -1;
  int _points = 0;

  final Random _random = new Random();

  int randomInt(int min, int max) => min + _random.nextInt(max - min);

  void _resetRound() {
    int next = randomInt(1, 9);
    setState(() {
      _active = next;
    });
  }

  void _start() {
    setState(() {
      _running = true;
    });
    _resetRound();
  }

  void _onPressed(int position) {
    setState(() {
      _points += 10;
    });
    _resetRound();
  }

  int _calculatePosition(int row, int col) {
    return col + (row * 3) + 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Whack-a-Mole")),
      body: Center(
        child: Column(
          children: [
            if (_running == true) Text("$_points points"),
            ...List.generate(3, (row) {
              return Row(
                children: List.generate(3, (col) {
                  return TextButton(
                    onPressed: _calculatePosition(row, col) == _active
                        ? () => _onPressed(_calculatePosition(row, col))
                        : null,
                    child: Text(_calculatePosition(row, col).toString()),
                  );
                }),
                mainAxisAlignment: MainAxisAlignment.center,
              );
            }),
            if (_running == false)
              TextButton(onPressed: _start, child: Text("Start")),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }
}
