import 'package:dorc_town/graphics/hud_components/hud_button.dart';
import 'package:dorc_town/structures/structure_component.dart';

import 'package:flame/components.dart';

class BreedingCave extends StructureComponent {
  BreedingCave(super.gridSize);

  @override
  Future<void> onLoad() async {
    sprite = Sprite(game.images.fromCache('habitats/breeding_cave.png'));
    hudComponentInit();
    return super.onLoad();
  }

  @override
  void hudComponentInit() {
    super.hudComponentInit();
    hudComponent.addHudButton(
      HudButton(
        buttonImage: 'experimental/sell.png',
        f: sellStructure,
      ),
      hudButtonPosition,
      hudSize,
    );
    hudButtonPosition -= Vector2(150, 0);
    hudComponent.addHudButton(
      HudButton(
        buttonImage: 'shop/dorc_button.png',
        f: sellStructure,
      ),
      hudButtonPosition,
      hudSize,
    );
  }
}
