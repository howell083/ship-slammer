import 'package:flame_rive/flame_rive.dart';
import 'package:flame/components.dart';

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