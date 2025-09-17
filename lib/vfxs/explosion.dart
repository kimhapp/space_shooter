import 'dart:async';

import 'package:flame/components.dart';
import 'package:space_shooter/actors/enemy/enemy.dart';
import 'package:space_shooter/space_shooter.dart';

class Explosion extends SpriteAnimationComponent with HasGameReference<SpaceShooterGame> {
  Explosion({super.position}) : super(size: Vector2.all(Enemy.enemySize * 1.5), anchor: Anchor.center, removeOnFinish: true);

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    animation = await game.loadSpriteAnimation('VFX/explosion.png', SpriteAnimationData.sequenced(
      amount: 4, stepTime: 0.15, textureSize: Vector2.all(8), loop: false
    ));
  }
}