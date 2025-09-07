import 'dart:async';

import 'package:flame/components.dart';
import 'package:space_shooter/space_shooter.dart';

class Bullet extends SpriteComponent with HasGameReference<SpaceShooterGame> {
  Bullet({super.position}) : super(
    size: Vector2.all(32), anchor: Anchor.center
  );

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    sprite = await game.loadSprite('bullet.png');
  }

  @override
  void update(double dt) {
    position.y += dt * -500;

    if (position.y < -height) removeFromParent();
    super.update(dt);
  }
}