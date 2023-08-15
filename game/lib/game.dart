import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:game/world.dart';

class Jueguito extends FlameGame {
  Jueguito();

  final mundito = Mundito();

  @override
  FutureOr<void> onLoad() async {
    images.prefix = '';

    final cameraComponent = CameraComponent(world: mundito);
    cameraComponent.viewfinder.anchor = Anchor.topLeft;

    add(mundito);
    add(cameraComponent);
  }
}
