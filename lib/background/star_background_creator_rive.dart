import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:ship_slammer/background/star_component_rive.dart';

class StarBackgroundCreator extends Component with HasGameRef {
  final gapSize = 20;

  late var starBoard = Artboard();
  Random random = Random();

  StarBackgroundCreator();

  @override
  Future<void> onLoad() async {
    starBoard = await loadArtboard(RiveFile.asset('assets/star.riv'));

    final starGapTime = (game.size.y / gapSize) / StarComponent.speed;

    add(
      TimerComponent(
        period: starGapTime,
        repeat: true,
        onTick: () => _createRowOfStars(-50),
      ),
    );
    _createInitialStars();
  }
  void _createStarAt(double x, double y){
    game.add(
        StarComponent(starBoard)
        ..position = Vector2(x, y)
        ..size = Vector2.all(25)
    );
  }
  void _createRowOfStars(double y){
    const rowGapSize = 6;
    final starGap = game.size.x / rowGapSize;

    for(var i = 0; i < rowGapSize; i++){
      _createStarAt(
        starGap * i +(random.nextDouble() * starGap),
        y + (random.nextDouble() * 20),
      );
    }
  }
  void _createInitialStars(){
    final rows = game.size.y / gapSize;
    for(var i =0; i < (gapSize +50); i++){
      _createRowOfStars((i * rows)-50);
    }
  }
}