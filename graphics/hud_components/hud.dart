import 'package:dorc_town/game/dorc_town.dart';
import 'package:dorc_town/graphics/hud_components/asset_icon.dart';
import 'package:dorc_town/graphics/hud_components/hud_button.dart';
import 'package:dorc_town/graphics/hud_components/hud_component.dart';

import 'package:flame/components.dart';

enum HudFace {
  standard,
  market,
  shop,
  treasure,
}

class Hud extends PositionComponent with HasGameRef<DorcTown> {
  //late HudButton moveStructure;
  late AssetIcon coinIcon;
  late AssetIcon expBar;
  late AssetIcon feedIcon;
  late AssetIcon gemIcon;

  late HudComponent assets;
  late HudComponent standard;
  late HudComponent placeStructure;
  late HudComponent moveStructure;

  late HudComponent current;
  late HudComponent upcoming;

  Hud({
    super.position,
    super.size,
    super.scale,
    super.angle,
    super.anchor,
    super.children,
    super.priority = 500,
  }) {
    positionType = PositionType.viewport;
    standard = HudComponent();
    upcoming = HudComponent();
    placeStructure = HudComponent();
    moveStructure = HudComponent();
  }

  @override
  Future<void> onLoad() async {
    Vector2 position = Vector2(1120, 570);
    Vector2 size = Vector2.all(128);
    standard.addHudButton(
      HudButton(
        buttonImage: 'hud/awsome_button.png',
        f: goToMarket,
      ),
      position,
      size,
    );
    current = standard;
    add(current);

    placeStructure.addHudButton(
      HudButton(
        buttonImage: 'hud/awsome_button_cross.png',
        f: cancelPurchase,
      ),
      position,
      size,
    );

    moveStructure.addHudButton(
      HudButton(
        buttonImage: 'hud/awsome_button_cross.png',
        f: cancelMovement,
      ),
      position,
      size,
    );

    placeStructure.addHudButton(
      HudButton(
        buttonImage: 'hud/awsome_button_check.png',
        f: approvePlacement,
      ),
      position - Vector2(150, 0),
      size,
    );

    moveStructure.addHudButton(
      HudButton(
        buttonImage: 'hud/awsome_button_check.png',
        f: approvePlacement,
      ),
      position - Vector2(150, 0),
      size,
    );

    var sizeI = Vector2(200, 40);
    var positionI = Vector2(200, 20);
    expBar = AssetIcon(
      position: positionI,
      size: sizeI,
      assetValue: game.recources.exp,
      assetImage: 'experimental/image.png',
    );
    coinIcon = AssetIcon(
      position: positionI + Vector2(250, 0),
      size: sizeI,
      assetValue: game.recources.coin,
      assetImage: 'experimental/image.png',
    );
    feedIcon = AssetIcon(
      position: positionI + Vector2(500, 0),
      size: sizeI,
      assetValue: game.recources.feed,
      assetImage: 'experimental/image.png',
    );
    gemIcon = AssetIcon(
      position: positionI + Vector2(750, 0),
      size: sizeI,
      assetValue: game.recources.gem,
      assetImage: 'experimental/image.png',
    );
    add(coinIcon);
    add(expBar);
    add(feedIcon);
    add(gemIcon);
    return super.onLoad();
  }

  void changeHud() {
    remove(current);
    add(upcoming);
    current = upcoming;
  }

  void goToMarket() {
    game.overlays.add('Market');
  }

  void approvePlacement() {
    if (!game.ts.canBePlaced) return;
    game.placeStructure();
    setStandard();
  }

  void cancelPurchase() {
    game.cancelPurchase();
    setStandard();
  }

  void cancelMovement() {
    game.cancelMovement();
    setStandard();
  }

  void setStandard() {
    upcoming = standard;
    changeHud();
  }

  void setStructureHud(HudComponent hc) {
    upcoming = hc;
    changeHud();
  }
}
