import 'dart:developer' as developer;
import 'package:flame/collisions.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:flame/components.dart';
import 'package:ship_slammer/components/player_component.dart';

class BashEnemy extends RiveComponent {
  BashEnemy(Artboard artboard) : super(artboard: artboard);
  SMIInput<bool>? _deathInput;
  SMIInput<bool>? _brokeInput;

  @override
  void onLoad() {
    final controller = StateMachineController.fromArtboard(artboard, 'basherState');
    if (controller != null){
      artboard.addController(controller);
      _deathInput = controller.findInput('explode');
      _brokeInput = controller.findInput('break');
      _deathInput?.value = false;
      _brokeInput?.value = false;
    }
  }
  void changeBash(String name, bool swap){
    final death = _deathInput;
    final broke = _brokeInput;

    if(_deathInput == null || _brokeInput == null){
      return;
    }
    switch (name) {
      case 'dead':
        developer.log('basher dead $swap');
        _deathInput?.value = swap;

        break;
      case 'broke':
        developer.log('basher broken $swap');
        _brokeInput?.value = swap;
        break;
    }
  }

}
class Basher extends PositionComponent with CollisionCallbacks {
  late var basherArtboard;
  bool debugMode = true;
  late Timer interval = Timer(1, onTick: () => basherArtboard.changeBash('dead', false), repeat: false, autoStart: false);

  @override
  void onLoad() async {
    basherArtboard =
    BashEnemy(await loadArtboard(RiveFile.asset('assets/enemybasher.riv')));
    add(basherArtboard..size = size);
    add(RectangleHitbox(position: Vector2(0, 30), size: Vector2(100, 45)));
  }
  @override
  void onCollision (Set<Vector2> intersectionPoints, PositionComponent other,) {
    developer.log('hit player');
    basherArtboard.changeBash('dead', true);
    basherArtboard.changeBash('broke', true);
    interval.start();
  }
  @override
  void update(double dt){
    interval.update(dt);
  }
}