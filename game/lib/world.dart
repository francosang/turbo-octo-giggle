import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:game/actores/player.dart';

const double imageSize = 16;
const double tileScale = 4;
const double tileSize = imageSize * tileScale;

class Mundito extends World {
  @override
  FutureOr<void> onLoad() async {
    final map = await TiledComponent.load(
      "world.tmx",
      Vector2.all(tileSize),
    );

    final p = Player(position: Vector2(20, 20));

    add(p);
    add(map);
  }
}
