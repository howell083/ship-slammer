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
class HealthBar extends RiveComponent {
  HealthBar(Artboard artboard) : super(artboard: artboard);
  SMIInput<double>? _hpInput;

  @override
  void onLoad() {
    final controller = StateMachineController.fromArtboard(artboard, 'HealthState');
    if (controller != null){
      artboard.addController(controller);
      _hpInput = controller.findInput('HP');
      _hpInput?.value = 100;
    }
  }
  void adjustHP(double dt) {
    final healthInput = _hpInput;
    if(_hpInput == null){
      return;
    }
    healthInput?.value += dt;
  }
}
class Health extends PositionComponent {
  late var healthArtboard;
  @override
  void onLoad() async {
    healthArtboard =
       HealthBar( await loadArtboard(RiveFile.asset('assets/hp_bar.riv')));
    add(healthArtboard..size = size);
  }
  void adjustHealth(double dt){
    healthArtboard.adjustHP(dt);
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