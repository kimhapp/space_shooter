import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/cupertino.dart';
import 'package:space_shooter/actor/player.dart';

class SpaceShooterGame extends FlameGame with PanDetector {
  late Player player;

  @override
  FutureOr<void> onLoad() async {
    final parallax = await loadParallaxComponent(
      [
        ParallaxImageData('bg_01.png'),
        ParallaxImageData('bg_02.png'),
        ParallaxImageData('bg_03.png'),
      ],
      baseVelocity: Vector2(0, -5),
      repeat: ImageRepeat.repeat,
      velocityMultiplierDelta: Vector2(0, 5)
    );
    add(parallax);

    player = Player();
    add(player);
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    player.move(info.delta.global);
    super.onPanUpdate(info);
  }
}