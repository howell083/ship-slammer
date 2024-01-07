import 'dart:math';
import 'dart:developer' as developer;

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(GameWidget(game: ShipSlammerGame()),);
}

class Stars extends RiveComponent {
  Stars(Artboard artboard) : super(artboard: artboard);
  @override
  void onLoad() {
    final controller = StateMachineController.fromArtboard(artboard, 'testMachine');
    if (controller != null){
      artboard.addController(controller);
    }
  }
}
class SlamShip extends RiveComponent {
  SlamShip(Artboard artboard) : super(artboard: artboard);
  @override
  void onLoad() {
    final controller = StateMachineController.fromArtboard(artboard, 'slamship');
    if (controller != null){
      artboard.addController(controller);
    }
  }
}
class BashEnemy extends RiveComponent {
  BashEnemy(Artboard artboard) : super(artboard: artboard);
  @override
  void onLoad() {
    final controller = StateMachineController.fromArtboard(artboard, 'basherState');
    if (controller != null){
      artboard.addController(controller);
    }
  }
}
class Basher extends PositionComponent {
  var basherArtboard = Artboard();

  @override
  void onLoad() async {
    basherArtboard =
        await loadArtboard(RiveFile.asset('assets/enemybasher.riv'));
        add(BashEnemy(basherArtboard)..size = size);
  }
}
class Player extends PositionComponent {
  var slamArtboard = Artboard();

  @override
  void onLoad() async {
    slamArtboard =
        await loadArtboard(RiveFile.asset('assets/dropship.riv'));
        add(SlamShip(slamArtboard)..size = size);
  }

}
class BackgroundStars extends PositionComponent {
  var starsArtboard = Artboard();

  @override
  void onLoad() async {
    starsArtboard =
        await loadArtboard(RiveFile.asset('assets/seaofstars.riv'));
        add(Stars(starsArtboard)..size = size);
  }


}

class ShipSlammerGame extends FlameGame with KeyboardEvents {
  @override
  final Vector2 canvasSize = Vector2(500, 500);
  final Vector2 viewportResolution = Vector2(500, 500);
  late BackgroundStars bgstars;
  late Player player;
  late Basher basher;

  late final CameraComponent cameraComponent;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final world = World();
    cameraComponent = CameraComponent.withFixedResolution(width: canvasSize.x, height: canvasSize.y, world: world);
    addAll([world, cameraComponent]);
    world.add(bgstars = BackgroundStars()
                ..position = Vector2(0, 0)
                ..width = 500
                ..height = 1500
                ..anchor = Anchor.center);
    world.add(basher = Basher()
                ..position = Vector2(0, -100)
                ..height = 100
                ..width = 100
                ..angle = pi
                ..anchor = Anchor.center);
    world.add(player = Player()
                ..position = Vector2(0, 100)
                ..height = 100
                ..width = 100
                ..angle = pi

                ..anchor = Anchor.center);
  }
}