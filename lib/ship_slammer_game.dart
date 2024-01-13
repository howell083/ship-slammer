import 'dart:math';
import 'dart:developer' as developer;

import 'package:ship_slammer/components/player_component.dart';
import 'package:ship_slammer/components/enemy_component.dart';
import 'package:ship_slammer/background/star_component_prototype.dart';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:flutter/services.dart';


class ShipSlammerGame extends FlameGame with HasKeyboardHandlerComponents {
  @override
  final Vector2 canvasSize = Vector2(500, 500);
  final Vector2 viewportResolution = Vector2(500, 500);
  late BackgroundStars _bgstars;
  late Player _player;
  late Basher _basher;

  late final CameraComponent cameraComponent;

  static const int _speed = 200;
  final Vector2 _direction = Vector2.zero();
  final Map<LogicalKeyboardKey, double> _keyWeights = {
    LogicalKeyboardKey.arrowUp: 0,
    LogicalKeyboardKey.arrowDown: 0,
    LogicalKeyboardKey.arrowLeft: 0,
    LogicalKeyboardKey.arrowRight: 0,
  };

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final world = World();
    cameraComponent = CameraComponent.withFixedResolution(width: canvasSize.x, height: canvasSize.y, world: world);
    addAll([world, cameraComponent]);
    world.add(_bgstars = BackgroundStars()
      ..position = Vector2(0, 0)
      ..width = 500
      ..height = 1500
      ..anchor = Anchor.center);
    world.add(_basher = Basher()
      ..position = Vector2(0, -100)
      ..height = 100
      ..width = 100
      ..angle = pi
      ..anchor = Anchor.center);
    world.add(_player = Player()
      ..position = Vector2(0, 100)
      ..height = 100
      ..width = 100
      ..angle = pi

      ..anchor = Anchor.center);
    add(
      KeyboardListenerComponent(
        keyUp: {
          LogicalKeyboardKey.arrowRight: (keys) =>
              _handleKey(LogicalKeyboardKey.arrowRight, false),
          LogicalKeyboardKey.arrowLeft: (keys) =>
              _handleKey(LogicalKeyboardKey.arrowLeft, false),
          LogicalKeyboardKey.arrowDown: (keys) =>
              _handleKey(LogicalKeyboardKey.arrowDown, false),
          LogicalKeyboardKey.arrowUp: (keys) =>
              _handleKey(LogicalKeyboardKey.arrowUp, false),
        },
        keyDown: {
          LogicalKeyboardKey.arrowRight: (keys) =>
              _handleKey(LogicalKeyboardKey.arrowRight, true),
          LogicalKeyboardKey.arrowLeft: (keys) =>
              _handleKey(LogicalKeyboardKey.arrowLeft, true),
          LogicalKeyboardKey.arrowDown: (keys) =>
              _handleKey(LogicalKeyboardKey.arrowDown, true),
          LogicalKeyboardKey.arrowUp: (keys) =>
              _handleKey(LogicalKeyboardKey.arrowUp, true),
        },
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);

    _direction
      ..setValues(xInput, yInput)
      ..normalize();
    final displacement = _direction * (_speed * dt);
    _player.position.sub(displacement);
  }

  bool _handleKey(LogicalKeyboardKey key, bool isDown) {
    _keyWeights[key] = isDown ? 1 : 0;
    return true;
  }

  double get xInput =>
      _keyWeights[LogicalKeyboardKey.arrowLeft]! -
          _keyWeights[LogicalKeyboardKey.arrowRight]!;
  double get yInput =>
      _keyWeights[LogicalKeyboardKey.arrowUp]! -
          _keyWeights[LogicalKeyboardKey.arrowDown]!;
}