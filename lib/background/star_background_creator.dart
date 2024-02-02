import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:ship_slammer/background/star_component.dart';

class StarBackgroundCreator extends Component with HasGameRef {
  final gapSize = 20;
  
  late final SpriteSheet starSheet;
  Random random = Random();
  
  StarBackgroundCreator();
  
  @override
  Future<void> onLoad() async {
    starSheet = SpriteSheet.fromColumnsAndRows(image: await game.images.load('starsheet.png'), columns: 4, rows: 4,);

    final starGapTime = (game.size.y / gapSize) / StarComponent.speed;

    add(
      TimerComponent(
          period: starGapTime,
          repeat: true,
          onTick: () => _createRowOfStars(0)
      ),
    );
    _createInitialStars();
  }
  void _createStarAt(double x, double y){
    final twinkleAnimation = starSheet.createAnimation(row: random.nextInt(4), to: 4, stepTime: 0.1,)..variableStepTimes = [max(20, 100 * random.nextDouble()), 0.1, 0.1, 0.1];

    double sizeVariant = (random.nextDouble() * 3) * 7;
    game.add(
        StarComponent(
            animation: twinkleAnimation,
            position: Vector2(x, y)
        )..size = Vector2.all(sizeVariant)
    );
  }
  void _createRowOfStars(double y) {
    const rowGapSize = 6;
    final starGap = game.size.x / rowGapSize;

    for(var i = 0; i < rowGapSize; i++){
      _createStarAt(
        starGap * i +(random.nextDouble() * starGap),
        y + (random.nextDouble() * 20),
      );
    }
  }
  void _createInitialStars() {
    final rows = game.size.y / gapSize;
    for (var i = 0; i < gapSize; i++){
      _createRowOfStars(i * rows);
    }
  }
}