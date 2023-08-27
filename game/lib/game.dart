import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:game/world.dart';

class Jueguito extends FlameGame {
  Jueguito();

  final mundito = Mundito();
  final cameraComponent = CameraComponent();

  @override
  FutureOr<void> onLoad() async {
    images.prefix = '';

    cameraComponent.world = mundito;
    cameraComponent.viewfinder.anchor = Anchor.center;

    add(mundito);
    add(cameraComponent);
  }
}
