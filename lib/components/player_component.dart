import 'package:flame/collisions.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:flame/components.dart';

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
class Player extends PositionComponent with CollisionCallbacks{
  var slamArtboard = Artboard();
  bool debugMode = true;

  @override
  void onLoad() async {
    slamArtboard =
    await loadArtboard(RiveFile.asset('assets/dropship.riv'));
    add(SlamShip(slamArtboard)..size = size);
    add(RectangleHitbox(position: Vector2(40, 30), size: Vector2(20, 40)));
  }

}