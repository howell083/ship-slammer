import 'package:flame/components.dart';
import 'package:flame_rive/flame_rive.dart';
class StarComponent extends RiveComponent with HasGameRef {
  static const speed = 20;

  StarComponent(Artboard artboard) : super(artboard: artboard);
  @override
  void onLoad() {
    final controller = StateMachineController.fromArtboard(artboard, 'starMachine',);
    if(controller != null){
      artboard.addController(controller);

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
}