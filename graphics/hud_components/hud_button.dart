import 'package:dorc_town/game/dorc_town.dart';

import 'package:flame/components.dart';
import 'package:flame/events.dart';

class HudButton extends SpriteComponent
    with Draggable, Tappable, HasGameRef<DorcTown> {
  late String buttonImage;
  late Function() f;

  HudButton({
    required this.buttonImage,
    required this.f,
  }) {
    positionType = PositionType.viewport;
  }

  @override
  Future<void> onLoad() async {
    sprite = Sprite(game.images.fromCache(buttonImage));
  }

  @override
  bool onTapDown(TapDownInfo info) {
    f();
    info.handled = true;
    return true;
  }
}
