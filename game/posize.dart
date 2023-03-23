import 'package:flame/components.dart';

class Posize {
  final sleeping = Vector2(-10000, -10000);
  final structure = Vector2(3, 3);
  final structuresrc = Vector2(3, 3);
  final pre = Vector2(256, 256);

  //mlp is the game size multiplier
  final double mlp = 1;

  final double standardsrc = 128.0;
  late double standard;

  late Vector2 real;
  late Vector2 realsrc;

  Posize() {
    standard = 128.0 * mlp;
  }

  setRealSize() {
    real = structure * standard;
    realsrc = structuresrc * standardsrc;
  }
}
