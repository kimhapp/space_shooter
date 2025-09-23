import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/cupertino.dart';
import 'package:space_shooter/space_shooter.dart';

import '../actors/player.dart';

class GameHud extends PositionComponent with HasGameReference<SpaceShooterGame> {
  final Player player;
  late final JoystickComponent joystick;
  late final HudButtonComponent shootButton;
  late final HudButtonComponent boostButton;
  late final HudButtonComponent skillButton;

  GameHud({required this.player});

  @override
  FutureOr<void> onLoad() async {
    joystick = JoystickComponent(
        knob: SpriteComponent(
            sprite: await game.loadSprite("HUD/knob.png"),
            size: Vector2.all(32)
        ),
        background: SpriteComponent(
            sprite: await game.loadSprite("HUD/joystick.png"),
            size: Vector2.all(64)
        ),
        margin: const EdgeInsets.only(left: 32, bottom: 32)
    );

    player.joystick = joystick;

    shootButton = HudButtonComponent(
        button: SpriteComponent(
            sprite: await game.loadSprite("HUD/shoot_button.png"),
            size: Vector2.all(48)
        ),
        buttonDown: SpriteComponent(
            sprite: await game.loadSprite("HUD/shoot_button_down.png"),
            size: Vector2.all(48)
        ),
        margin: const EdgeInsets.only(right: 32, bottom: 32),
        onPressed: () {
          player.startShooting();
        },
        onReleased: () {
          player.stopShooting();
        }
    );
    skillButton = HudButtonComponent(
        button: SpriteComponent(
            sprite: await game.loadSprite("HUD/skill_button.png"),
            size: Vector2.all(48)
        ),
        buttonDown: SpriteComponent(
            sprite: await game.loadSprite("HUD/shoot_button_down.png"),
            size: Vector2.all(48)
        ),
        margin: const EdgeInsets.only(right: 32, bottom: 96),
        onPressed: () {
          if (!player.isSkillActive && player.energy >= player.maxEnergy) player.skillActivate();
        }
    );
    boostButton = HudButtonComponent(
        button: SpriteComponent(
            sprite: await game.loadSprite("HUD/boost_button.png"),
            size: Vector2.all(48)
        ),
        buttonDown: SpriteComponent(
            sprite: await game.loadSprite("HUD/boost_button_down.png"),
            size: Vector2.all(48)
        ),
        margin: const EdgeInsets.only(right: 96, bottom: 32),
        onPressed: () {
          player.startBoosting();
        },
        onReleased: () {
          player.stopBoosting();
        }
    );

    game.camera.viewport.add(joystick);
    game.camera.viewport.add(shootButton);
    game.camera.viewport.add(skillButton);
    game.camera.viewport.add(boostButton);
    return super.onLoad();
  }
}