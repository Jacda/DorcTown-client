import 'package:dorc_town/game/dorc_catalog.dart';
import 'package:dorc_town/game/posize.dart';
import 'package:dorc_town/game/targeted_structure.dart';
import 'package:dorc_town/recources/island.dart';
import 'package:dorc_town/recources/dorc.dart';
import 'package:dorc_town/recources/asset_class.dart';

import 'package:dorc_town/structures/selector/selector.dart';
import 'package:dorc_town/graphics/hud_components/hud.dart';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flame/input.dart';
import 'package:flame/extensions.dart';

class DorcTown extends FlameGame
    with
        HasTappables,
        HasDraggables,
        ScrollDetector,
        MouseMovementDetector,
        HasCollisionDetection {
  DorcTown();

  late TargetedStructure ts;
  late AssetClass recources;
  late Hud hud;
  late Posize psz;
  late DorcCatalog dc;

  late Image selectorImage;
  late Selector selector;

  var screenSnap = Vector2(500, 300);

  late Dorc targetedDorc;

  late Island mainIsland;
  late Island secondaryIsland;

  late Image standardImage;

  final matrix = [
    [0, 1, 2],
    [-1, 1, 1]
  ];

  @override
  Future<void> onLoad() async {
    super.onLoad();
    camera.viewport = FixedResolutionViewport(Vector2(1280, 720));
    debugMode = false;
    await images.loadAll([
      'experimental/ground_sprite.png',
      'experimental/tile.png',
      'experimental/tile1.png',
      'experimental/image.png',
      'experimental/facei.png',
      'experimental/sell.png',
      'tiles/tile2.png',
      'tiles/highlight.png',
      'habitats/yog_habit.png',
      'habitats/yoghurt_habitat.png',
      'habitats/breeding_cave.png',
      'hud/awsome_button.png',
      'hud/awsome_button_cross.png',
      'hud/awsome_button_check.png',
      'hud/move_button.png',
      'shop/building_button.png',
      'shop/dorc_button.png',
      'shop/habitat_button.png',
      'shop/purchase_back.png',
      'shop/shop_backdrop.png',
      'shop/shop_backdrop2.png',
      'shop/market.png',
      'alpha1.png',
    ]);
    standardImage = images.fromCache('experimental/ground_sprite.png');
    initBaseMap();
    camera.followVector2(screenSnap);
    camera.zoom = 1;
  }

  @override
  void onTapDown(int pointerId, TapDownInfo info) {
    super.onTapDown(pointerId, info);
    if (ts.isTargeted && !info.handled) {
      deTarget();
    }
  }

  @override
  bool onDragUpdate(int pointerId, DragUpdateInfo info) {
    super.onDragUpdate(pointerId, info);
    if (info.handled) return true;
    screenSnap -= info.delta.game;
    camera.followVector2(screenSnap);
    return true;
  }

  @override
  void onScroll(PointerScrollInfo info) {
    camera.zoom -= info.scrollDelta.viewport.y.sign * camera.zoom * 0.08;
  }

  void buyStructure() {
    overlays.remove('Market');
    ts.setPurchaseReady();
    buyButtonPressed(screenSnap);
    hud.upcoming = hud.placeStructure;
    hud.changeHud();
  }

  void moveStructure() {
    ts.setMovementReady();
    buyButtonPressed(ts.lastPosition);
    hud.upcoming = hud.moveStructure;
    hud.changeHud();
  }

  void buyButtonPressed(Vector2 pos) {
    ts.placementReady = true;
    selectorImage = ts.current.sprite?.image ?? standardImage;
    psz.setRealSize();
    selector = Selector(
      psz.real,
      selectorImage,
      psz.realsrc,
    );
    add(selector);
    selector.setStartPosition(pos);
    selector.setPriority(300);
  }

  void cancelPurchase() {
    remove(ts.current);
    cancelPlacement();
  }

  void cancelMovement() {
    ts.current.setPostition(ts.lastPosition);
    cancelPlacement();
  }

  void placeStructure() {
    ts.current.setPostition(selector.position);
    cancelPlacement();
  }

  void cancelPlacement() {
    ts.setAllFalse();
    remove(selector);
  }

  void deTarget() {
    hud.setStandard();
    ts.isTargeted = false;
  }

//-------------------------------INIT GAME
  void initBaseMap() {
    hud = Hud();
    recources = AssetClass();
    ts = TargetedStructure();
    psz = Posize();
    dc = DorcCatalog();
    add(hud);
    add(recources);
    add(ts);

    final tileset = SpriteSheet(
      image: images.fromCache('tiles/tile2.png'),
      srcSize: Vector2.all(psz.standardsrc),
    );

    add(mainIsland = (Island(
      position: psz.pre,
      tileset: tileset,
      islandSize: 15,
    )));

    add(secondaryIsland = (Island(
      position: psz.pre + Vector2(2048, -512),
      tileset: tileset,
      islandSize: 15,
    )));

    add(IsometricTileMapComponent(tileset, matrix,
        position: Vector2(100, 100),
        destTileSize: Vector2.all(psz.standard / 2)));
  }
}
