import 'package:dorc_town/game/dorc_town.dart';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/input.dart';
import 'package:flame/collisions.dart';

class Selector extends SpriteComponent
    with
        HasGameRef<DorcTown>,
        CollisionCallbacks,
        Draggable,
        Tappable,
        GestureHitboxes {
  bool show = true;

  //if colliding = 0, then selector is outside island
  //if colliding = 1 then selector is inside island
  //if colliding => 2 then selector is one the side
  //of island or ontop of a structure
  int colliding = 0;

  late bool draggable;
  late Vector2 realPosition;
  late Vector2 snapPosition;
  late Block block;
  late ShapeHitbox hitbox;

  Selector(Vector2 s, Image image, Vector2 srcSize)
      : super(
            sprite: Sprite(image, srcSize: srcSize),
            size: s,
            anchor: Anchor.topLeft);

  @override
  Future<void> onLoad() async {
    hitbox = setShape();
    add(hitbox);
    super.onLoad();
  }

  void setStartPosition(Vector2 startPosition) {
    realPosition = startPosition + (Vector2(50, 25) * game.psz.mlp);
    final block = game.mainIsland.base.getBlock(realPosition);
    final hoverPosition = game.mainIsland.base.getBlockRenderPosition(block);
    snapPosition = hoverPosition;
    position = snapPosition.clone();
  }

  PolygonHitbox setShape() {
    final top = Vector2(size.x / 2, size.y / 2);
    final right = Vector2(size.x, size.y * (3 / 4));
    final bottom = Vector2(size.x / 2, size.y);
    final left = Vector2(0, size.y * (3 / 4));
    return PolygonHitbox([
      top + Vector2(0, 20),
      left + Vector2(20, 0),
      bottom - Vector2(0, 20),
      right - Vector2(20, 0)
    ]);
  }

  @override
  bool onTapDown(TapDownInfo info) {
    return true;
  }

  @override
  bool onDragUpdate(DragUpdateInfo info) {
    realPosition += info.delta.game;
    final block = game.mainIsland.base.getBlock(realPosition);
    final hoverPosition = game.mainIsland.base.getBlockRenderPosition(block);
    snapPosition = hoverPosition;
    if (colliding != 1) {
      position = realPosition.clone() - (Vector2(63, 32) * game.psz.mlp);
    } else {
      position = snapPosition.clone();
    }
    info.handled = true;
    return true;
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (colliding == 1) {
      game.ts.canBePlaced = false;
    } else {
      game.ts.canBePlaced = true;
    }
    colliding += 1;
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    colliding -= 1;
    if (colliding == 1) {
      game.ts.canBePlaced = true;
    } else {
      game.ts.canBePlaced = false;
    }
  }

  @override
  void render(Canvas canvas) {
    if (!show) {
      return;
    }
    super.render(canvas);
  }

  void setPriority(prio) {
    priority = prio.round();
  }
}
