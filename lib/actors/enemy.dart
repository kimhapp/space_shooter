import 'dart:async';

import 'package:flame/components.dart';
import 'package:space_shooter/space_shooter.dart';

class Enemy extends SpriteComponent with HasGameReference<SpaceShooterGame> {
  Enemy({super.position}) : super(size: Vector2.all(enemySize), anchor: Anchor.center);

  static const enemySize = 32.0;

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    sprite = await game.loadSprite('enemy.png');
  }

  @override
  void update(double dt) {
    super.update(dt);

    position.y += dt * 250;

    if (position.y > game.size.y) removeFromParent();
  }
}