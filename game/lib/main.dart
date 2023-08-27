import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:game/game.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GameWidget(game: Jueguito()),
    );
  }
}
