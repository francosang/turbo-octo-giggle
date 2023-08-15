import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:game/game.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GameWidget(game: Jueguito()),
    );
  }
}
