import 'dart:developer' as developer;

import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame_rive/flame_rive.dart';
class StarComponent extends RiveComponent with HasGameRef {
  static const speed = 20;

  StarComponent(Artboard artboard) : super(artboard: artboard);
  SMIInput<double>? _colorInput;
  SMITrigger? _twinkInput;
  Random random = Random();
  late double colorset = 0;
  StateMachineController? _controller;
  @override
  void onLoad() {
    //_controller = StateMachineController.fromArtboard(artboard, 'starMachine',);
    final controller = _controller;
    //developer.log('$colorSelector');
    if(controller != null){
      artboard.addController(controller);
      _colorInput = controller.findInput('color');
      _twinkInput = controller.findSMI('twinkle');
      _colorInput?.value = colorset;
    }
  }
  @override
  void update(double dt){
    super.update(dt);
    y += dt * speed;
    if (y >= game.size.y){
      removeFromParent();
    }

  }
  set colorInput (double color) => colorset = color;
  set controller (StateMachineController? control) => _controller = control;
}