import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:ship_slammer/background/star_component_rive.dart';

class StarCreator extends Component with HasGameRef {


  late var starBoard = Artboard();
  Random random = Random();
  @override
  Future<void> onLoad() async {
    starBoard = await loadArtboard(RiveFile.asset('assets/star.riv'));

  }
  void _createStarAt(double x, double y){
    double color = (random.nextDouble() * 4).floorToDouble();
    double sizeVariant = (random.nextDouble() * 25);
    StarComponent star = StarComponent(starBoard)
      ..controller = StateMachineController.fromArtboard(starBoard, 'starMachine')
      ..position = Vector2(x, y)
      ..size = Vector2.all(25 + sizeVariant)
      ..colorInput = color;
    game.add(
        star
    );
  }

}