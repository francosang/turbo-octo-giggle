import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game/game.dart';
import 'package:game/world.dart';

class Player extends SpriteComponent
    with HasGameRef<Jueguito>, KeyboardHandler {
  Player({
    required super.position,
  }) : super(
          size: Vector2.all(playerSize),
          anchor: Anchor.center,
          priority: 1,
        );

  var movement = Vector2.zero();
  var minPosition = Vector2.zero();
  var maxPosition = Vector2.zero();

  @override
  FutureOr<void> onLoad() async {
    minPosition = size / 2;
    maxPosition = game.mundito.map.size - (size / 2);

    final img = await game.images
        .load('assets/characters/Adventurer/Poses/adventurer_action1.png');
    sprite = Sprite(img);

    position = Vector2.all(20);
  }

  @override
  void update(double dt) {
    position.add(movement * playerSpeed * dt);
    position.clamp(minPosition, maxPosition);
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    debugPrint("KeyEvent: $event");

    if (keysPressed.contains(LogicalKeyboardKey.keyW)) {
      movement.y = -1;
    } else if (keysPressed.contains(LogicalKeyboardKey.keyS)) {
      movement.y = 1;
    } else {
      movement.y = 0;
    }

    if (keysPressed.contains(LogicalKeyboardKey.keyA)) {
      movement.x = -1;
    } else if (keysPressed.contains(LogicalKeyboardKey.keyD)) {
      movement.x = 1;
    } else {
      movement.x = 0;
    }

    movement.normalize();

    return movement.x == 0 && movement.y == 0;
  }
}
