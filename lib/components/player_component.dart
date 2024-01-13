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
class Player extends PositionComponent {
  var slamArtboard = Artboard();

  @override
  void onLoad() async {
    slamArtboard =
    await loadArtboard(RiveFile.asset('assets/dropship.riv'));
    add(SlamShip(slamArtboard)..size = size);
  }

}