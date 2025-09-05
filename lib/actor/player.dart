import 'dart:async';

import 'package:flame/components.dart';
import 'package:space_shooter/space_shooter.dart';

class Player extends SpriteComponent with HasGameReference<SpaceShooterGame> {
  Player() : super(size: Vector2.all(32), anchor: Anchor.center);

  @override
  FutureOr<void> onLoad() async {
    sprite = await game.loadSprite('player-sprite.png');
    position = game.size / 2;
    return super.onLoad();
  }

  void move(Vector2 delta) {
    position.add(delta);
  }
}