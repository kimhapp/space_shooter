import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:space_shooter/actor/player.dart';

class SpaceShooterGame extends FlameGame with PanDetector {
  late Player player;

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();
    
    final playerSprite = await loadSprite('player-sprite.png');
    player = Player()
      ..sprite = playerSprite
      ..x = size.x / 2
      ..y = size.y / 2
      ..width = 50
      ..height = 100
      ..anchor = Anchor.center;

    add(player);
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    player.move(info.delta.global);
    super.onPanUpdate(info);
  }
}