import 'dart:async';

import 'package:flame/components.dart';
import 'package:space_shooter/objects/bullet.dart';
import 'package:space_shooter/space_shooter.dart';

class Player extends SpriteComponent with HasGameReference<SpaceShooterGame> {
  Player() : super(size: Vector2.all(16), anchor: Anchor.center);

  late final SpawnComponent _bulletSpawner;
  final Vector2 direction = Vector2.zero();
  JoystickComponent? joystick;

  double moveSpeed = 200;
  double maxFuel = 100;
  double maxEnergy = 10;
  late double energy;
  late double fuel;
  double attackInterval = .2;
  double fuelRegen = 10;
  double fuelConsumption = 20;
  Timer skillDuration = Timer(10);
  double skillAttackInterval = .1;

  bool isShooting = false;
  bool isBoosting = false;
  bool isSkillActive = false;

  @override
  FutureOr<void> onLoad() async {
    sprite = await game.loadSprite('Characters/player/player-sprite.png');
    position = game.size / 2;
    fuel = maxFuel;
    energy = 0;

    _bulletSpawner = SpawnComponent(
      period: attackInterval,
      selfPositioning: true,
      factory: (index) {
        return Bullet(this, position: position + Vector2(0, -height / 2));
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

    if (!isBoosting) fuel = (fuel + fuelRegen * dt).clamp(0, maxFuel);
    if (isSkillActive) {
      skillDuration.update(dt);

      if (skillDuration.finished) skillDeactivate();
    }
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
    if (joystick != null && joystick?.direction != JoystickDirection.idle) {
      position.add(joystick!.relativeDelta * moveSpeed * dt);

      if (isBoosting && fuel > 0) {
        fuel = (fuel - fuelConsumption * dt).clamp(0, maxFuel);
      } else if (isBoosting && fuel <= 0){
        stopBoosting();
      }

      // Get the player's ship half size
      final halfWidth = width / 2;
      final halfHeight = height / 2;

      // Clamp the position so the ship won't go out of bound
      position.clamp(
          Vector2(halfWidth, halfHeight),
          Vector2(game.screenWidth - halfWidth, game.screenHeight - halfHeight)
      );
    }
  }

  void startBoosting() {
    moveSpeed = 400;
    isBoosting = true;
  }

  void stopBoosting() {
    moveSpeed = 200;
    isBoosting = false;
  }

  void skillActivate() {
    isSkillActive = true;
    _bulletSpawner.period -= skillAttackInterval;
    energy = 0;
  }

  void skillDeactivate() {
    isSkillActive = false;
    _bulletSpawner.period += skillAttackInterval;
  }
}