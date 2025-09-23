import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/cupertino.dart';
import 'package:space_shooter/actors/player.dart';

import 'UI/GameHud.dart';
import 'actors/enemy/enemy.dart';

class SpaceShooterGame extends FlameGame with HasCollisionDetection {
  late Player player;
  late GameHud hud;

  final double screenWidth = 640;
  final double screenHeight = 360;

  @override
  FutureOr<void> onLoad() async {
    camera = CameraComponent.withFixedResolution(width: screenWidth, height: screenHeight, world: world);
    camera.viewfinder.anchor = Anchor.topLeft;

    final parallax = await loadParallaxComponent(
      [
        ParallaxImageData('Backgrounds/bg_01.png'),
        ParallaxImageData('Backgrounds/bg_02.png'),
        ParallaxImageData('Backgrounds/bg_03.png'),
      ],
      baseVelocity: Vector2(0, -5),
      repeat: ImageRepeat.repeat,
      velocityMultiplierDelta: Vector2(0, 5)
    );
    world.add(parallax);

    player = Player();
    hud = GameHud(player: player);
    add(hud);
    world.add(player);

    world.add(
        SpawnComponent(
            period: 1,
            factory: (index) {
              return Enemy();
            },
            area: Rectangle.fromLTWH(0, 0, size.x, -Enemy.enemySize)
        )
    );
  }
}