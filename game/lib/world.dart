import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:game/actores/player.dart';
import 'package:game/game.dart';

const double imageSize = 16;
const double tileScale = 4;
const double tileSize = imageSize * tileScale;

class Mundito extends World with HasGameRef<Jueguito> {
  @override
  FutureOr<void> onLoad() async {
    final map = await TiledComponent.load(
      "world.tmx",
      Vector2.all(tileSize),
    );
    add(map);

    final player = Player(position: Vector2(20, 20));
    game.cameraComponent.follow(player);
    add(player);
  }
}
