import 'dart:async';

import 'package:flame/components.dart';
import 'package:game/game.dart';

class Player extends SpriteComponent with HasGameRef<Jueguito> {
  Player({
    required super.position,
  }) : super(size: Vector2.all(100), anchor: Anchor.topLeft);

  @override
  FutureOr<void> onLoad() async {
    final img = await game.images
        .load('assets/characters/Adventurer/Poses/adventurer_action1.png');

    sprite = Sprite(img);
  }
}
