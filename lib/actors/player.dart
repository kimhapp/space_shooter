import 'dart:async';

import 'package:flame/components.dart';
import 'package:space_shooter/objects/bullet.dart';
import 'package:space_shooter/space_shooter.dart';

class Player extends SpriteComponent with HasGameReference<SpaceShooterGame> {
  Player() : super(size: Vector2.all(16), anchor: Anchor.center);

  late final SpawnComponent _bulletSpawner;
  final Vector2 direction = Vector2.zero();
  double moveSpeed = 200;
  bool isShooting = false;

  @override
  FutureOr<void> onLoad() async {
    sprite = await game.loadSprite('Characters/player/player-sprite.png');
    position = game.size / 2;

    _bulletSpawner = SpawnComponent(
      period: .2,
      selfPositioning: true,
      factory: (index) {
        return Bullet(position: position + Vector2(0, -height / 2));
      },
      autoStart: false
    );
    game.world.add(_bulletSpawner);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    joystickMovement(dt);
  }

  void startShooting() {
    _bulletSpawner.timer.start();
    isShooting = true;
  }

  void stopShooting() {
    _bulletSpawner.timer.stop();
    isShooting = false;
  }

  void joystickMovement(double dt) {
    if (game.joystick.direction != JoystickDirection.idle) {
      position.add(game.joystick.relativeDelta * moveSpeed * dt);

      final screenWidth = 640;
      final screenHeight = 360;

      // Get the player's ship size
      final halfWidth = width / 2;
      final halfHeight = height / 2;

      // Clamp the position so the ship won't go out of bound
      position.clamp(
          Vector2(halfWidth, halfHeight),
          Vector2(screenWidth - halfWidth, screenHeight - halfHeight)
      );
    }
  }
}