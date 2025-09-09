import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:space_shooter/objects/bullet.dart';
import 'package:space_shooter/space_shooter.dart';
import 'package:space_shooter/vfxs/explosion.dart';

class Enemy extends SpriteComponent with HasGameReference<SpaceShooterGame>, CollisionCallbacks {
  Enemy({super.position}) : super(size: Vector2.all(enemySize), anchor: Anchor.center);

  static const enemySize = 48.0;

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    sprite = await game.loadSprite('enemy.png');
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);

    position.y += dt * 250;

    if (position.y > game.size.y) removeFromParent();
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);

    if (other is Bullet) {
      other.removeFromParent();
      removeFromParent();
      game.add(Explosion(position: position));
    }
  }
}
