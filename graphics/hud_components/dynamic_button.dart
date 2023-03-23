import 'package:dorc_town/graphics/hud_components/hud_button.dart';
import 'package:dorc_town/recources/asset_class.dart';
import 'package:dorc_town/structures/habitats/habitat.dart';

import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';

class DynamicButton extends HudButton {
  late Habitat habitat;
  late AssetType assetType;
  late TextComponent textComponent;
  late int assetValue;

  DynamicButton({
    required super.buttonImage,
    required super.f,
    required this.habitat,
    required this.assetType,
  }) {
    assetValue = habitat.bank.floor();
    textComponent = TextComponent(
      text: "$assetValue",
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 32,
          color: Color.fromRGBO(255, 255, 255, 1),
        ),
      ),
      anchor: Anchor.topCenter,
      position: Vector2(60, -3),
    );
  }

  @override
  Future<void> onLoad() async {
    add(textComponent);
    super.onLoad();
  }

  void refreshAsset() {
    assetValue = habitat.bank.floor();
    textComponent.text = "$assetValue";
  }
}
