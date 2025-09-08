import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/cupertino.dart';
import 'package:space_shooter/actors/player.dart';

import 'actors/enemy.dart';

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

    add(
        SpawnComponent(
            period: 1,
            factory: (index) {
              return Enemy();
            },
            area: Rectangle.fromLTWH(0, 0, size.x, -Enemy.enemySize)
        )
    );
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    super.onPanUpdate(info);
    player.move(info.delta.global);
  }

  @override
  void onPanStart(DragStartInfo info) {
    super.onPanStart(info);
    player.startShooting();
  }

  @override
  void onPanEnd(DragEndInfo info) {
    super.onPanEnd(info);
    player.stopShooting();
  }
}