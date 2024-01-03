import 'package:flutter/material.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_rive/flame_rive.dart';

void main() {
  runApp(GameWidget(game: ShipSlammerGame()),);
}

class ShipSlammerGame extends FlameGame {
}