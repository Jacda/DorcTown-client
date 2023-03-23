import 'package:dorc_town/game/dorc_town.dart';
import 'package:dorc_town/graphics/hud_components/hud_button.dart';

import 'package:flame/components.dart';

class HudComponent extends PositionComponent with HasGameRef<DorcTown> {
// component saves sets of buttons
  HudComponent() {
    positionType = PositionType.viewport;
  }

  addHudButton(HudButton button, Vector2 position, Vector2 size) {
    button.position = position;
    button.size = size;
    add(button);
  }
}
