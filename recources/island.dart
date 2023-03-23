import 'package:dorc_town/game/dorc_town.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

class Island extends PositionComponent with HasGameRef<DorcTown> {
  //creates two hitboxes
  //first hitbox is only on the edge
  //second hitbox is for the whole space
  late List<List<int>> islandMatrix;
  late SpriteSheet tileset;
  late int islandSize;
  late IsometricTileMapComponent base;
  late Vector2 basePosition;

  Island({
    //position has to be dividable by 64
    required super.position,
    required this.tileset,
    required this.islandSize,
  }) {
    islandMatrix = List.filled(islandSize, List.filled(islandSize, 0));
  }

  @override
  Future<void> onLoad() async {
    add(PolygonHitbox(islandCorners()));
    add(PolygonHitbox(islandCorners())..isSolid = true);
    add(base = IsometricTileMapComponent(
      tileset,
      islandMatrix,
      position: Vector2(0, 0),
      destTileSize: Vector2.all(game.psz.standard),
    ));
  }

  List<Vector2> islandCorners() {
    //Specific math because defining point
    //lies 64 units under the top corner.
    final Vector2 top = Vector2(0, -64);
    final Vector2 left = Vector2(-islandSize * 64, 32 * (islandSize - 2));
    final Vector2 bot = Vector2(0, 64 * (islandSize - 1));
    final Vector2 right = Vector2(islandSize * 64, 32 * (islandSize - 2));

    return [
      top - Vector2(0, 20),
      left - Vector2(20, 0),
      bot + Vector2(0, 20),
      right + Vector2(20, 0),
    ];
  }
}
