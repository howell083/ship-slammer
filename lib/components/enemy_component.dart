import 'dart:developer' as developer;
import 'package:flame/collisions.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:flame/components.dart';
import 'package:ship_slammer/components/player_component.dart';

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
class Basher extends PositionComponent with CollisionCallbacks {
  var basherArtboard = Artboard();
  bool debugMode = true;

  @override
  void onLoad() async {
    basherArtboard =
    await loadArtboard(RiveFile.asset('assets/enemybasher.riv'));
    add(BashEnemy(basherArtboard)..size = size);
    add(RectangleHitbox(position: Vector2(0, 30), size: Vector2(100, 45)));
  }
  @override
  void onCollision (Set<Vector2> intersectionPoints, PositionComponent other,) {
    developer.log('hit player');
  }
}