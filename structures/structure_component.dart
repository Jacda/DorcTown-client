import 'package:dorc_town/game/dorc_town.dart';
import 'package:dorc_town/graphics/hud_components/hud_button.dart';
import 'package:dorc_town/graphics/hud_components/hud_component.dart';
import 'package:dorc_town/recources/asset_class.dart';
import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flame/events.dart';

class StructureComponent extends SpriteComponent
    with GestureHitboxes, Tappable, CollisionCallbacks, HasGameRef<DorcTown> {
  late ShapeHitbox hitbox;
  late Vector2 gridSize;
  late Vector2 hudButtonPosition;
  late Vector2 hudSize;
  late HudComponent hudComponent;
  late int cost;

  StructureComponent(this.gridSize) : super(anchor: Anchor.topLeft) {
    positionType = PositionType.game;
    hudComponent = HudComponent();
    cost = 300;
  }

  @override
  Future<void> onLoad() async {
    size = gridSize * game.psz.standard;
    add(hitbox = setShape()..collisionType = CollisionType.passive);
    hitbox.isSolid = true;
    return super.onLoad();
  }

  ShapeHitbox setShape() {
    var top = Vector2(size.x / 2, size.y / 2);
    var right = Vector2(size.x, size.y * (3 / 4));
    var bottom = Vector2(size.x / 2, size.y);
    var left = Vector2(0, size.y * (3 / 4));
    return PolygonHitbox([
      top + Vector2(0, 20),
      left + Vector2(20, 0),
      bottom - Vector2(0, 20),
      right - Vector2(20, 0)
    ]);
  }

  void hudComponentInit() {
    hudButtonPosition = Vector2(1120, 570);
    hudSize = Vector2.all(128);
    hudComponent = HudComponent();
    hudComponent.addHudButton(
      HudButton(
        buttonImage: 'hud/move_button.png',
        f: game.moveStructure,
      ),
      hudButtonPosition,
      hudSize,
    );
    hudButtonPosition -= Vector2(150, 0);
  }

  void setPostition(Vector2 pos) {
    position = pos;
    priority = (pos.y / 32).round() + 100;
  }

  @override
  bool onTapDown(TapDownInfo info) {
    if (info.handled) return false;
    //can only target self if structureIsTargetd is false.
    //can never target when movementready or placement ready
    //is true
    bool canTarget = (!(this == game.ts.current) || !game.ts.isTargeted) &&
        !(game.ts.placementReady || game.ts.movementReady);
    if (canTarget) {
      game.ts.isTargeted = true;
      game.ts.current = this;
      game.hud.setStructureHud(hudComponent);
    }
    info.handled = true;
    return true;
  }

  void sellStructure() {
    //remove structure from game and add half
    //the habiat worth into coin asset
    game.remove(this);
    game.deTarget();
    game.recources.increaseRecource((cost / 2).floor(), AssetType.coins);
  }

  void sellDorc() {}
}
