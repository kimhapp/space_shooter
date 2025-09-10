import 'dart:async';

import 'package:flame/components.dart';
import 'package:space_shooter/objects/bullet.dart';
import 'package:space_shooter/space_shooter.dart';

class Player extends SpriteComponent with HasGameReference<SpaceShooterGame> {
  Player() : super(size: Vector2.all(32), anchor: Anchor.center);

  late final SpawnComponent _bulletSpawner;
  final Vector2 direction = Vector2.zero();
  double moveSpeed = 200;

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
    game.add(_bulletSpawner);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    joystickMovement();
    position += direction.scaled(moveSpeed * dt);
  }

  void move(Vector2 delta) {
    position.add(delta);
  }

  void startShooting() {
    _bulletSpawner.timer.start();
  }

  void stopShooting() {
    _bulletSpawner.timer.stop();
  }

  void joystickMovement() {
    switch (game.joystick.direction) {
      case JoystickDirection.left:
        direction.x = -1;
        direction.y = 0;
        break;
      case JoystickDirection.upLeft:
        direction.y = -1;
        direction.x = -1;
        break;
      case JoystickDirection.downLeft:
        direction.y = 1;
        direction.x = -1;
        break;
      case JoystickDirection.up:
        direction.y = -1;
        direction.x = 0;
        break;
      case JoystickDirection.down:
        direction.y = 1;
        direction.x = 0;
        break;
      case JoystickDirection.right:
        direction.x = 1;
        direction.y = 0;
        break;
      case JoystickDirection.upRight:
        direction.y = -1;
        direction.x = 1;
        break;
      case JoystickDirection.downRight:
        direction.y = 1;
        direction.x = 1;
        break;
      default:
        direction.y = 0;
        direction.x = 0;
        break;
    }
  }
}