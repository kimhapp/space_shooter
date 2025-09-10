import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/cupertino.dart';
import 'package:space_shooter/actors/player.dart';

import 'actors/enemy.dart';

class SpaceShooterGame extends FlameGame with HasCollisionDetection {
  late Player player;
  late final JoystickComponent joystick;

  @override
  FutureOr<void> onLoad() async {
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

    joystick = JoystickComponent(
        knob: SpriteComponent(
            sprite: await loadSprite("HUD/Knob.png"),
            size: Vector2.all(64)
        ),
        background: SpriteComponent(
            sprite: await loadSprite("HUD/Joystick.png"),
            size: Vector2.all(128)
        ),
        margin: const EdgeInsets.only(left: 64, bottom: 64)
    );
    add(joystick);
  }
}