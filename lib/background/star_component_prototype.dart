import 'package:flame_rive/flame_rive.dart';
import 'package:flame/components.dart';


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
class BackgroundStars extends PositionComponent {
  var starsArtboard = Artboard();

  @override
  void onLoad() async {
    starsArtboard =
    await loadArtboard(RiveFile.asset('assets/seaofstars.riv'));
    add(Stars(starsArtboard)..size = size);
  }


}