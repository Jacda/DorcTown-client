import 'package:dorc_town/game/dorc_town.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';

class AssetIcon extends SpriteComponent
    with Draggable, Tappable, HasGameRef<DorcTown> {
  late int assetValue;
  late String assetImage;
  late TextComponent textComponent;

  AssetIcon({
    required super.position,
    required super.size,
    required this.assetValue,
    required this.assetImage,
    super.scale,
    super.angle,
    super.anchor,
    super.priority,
  }) {
    positionType = PositionType.viewport;
  }

  @override
  Future<void> onLoad() async {
    sprite = Sprite(game.images.fromCache(assetImage));
    add(textComponent = TextComponent(
      text: "$assetValue",
      anchor: Anchor.topRight,
      position: Vector2(190, 5),
    ));
  }

  void refreshAsset(int asset) {
    assetValue = asset;
    textComponent.text = "$assetValue";
  }

  @override
  bool onTapUp(TapUpInfo info) {
    info.handled = true;
    if (game.ts.placementReady || game.ts.isTargeted) return false;
    game.overlays.add('Market');
    return false;
  }

  @override
  bool onDragUpdate(DragUpdateInfo info) {
    info.handled = true;
    return true;
  }
}
