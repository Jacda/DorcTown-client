import 'package:dorc_town/graphics/hud_components/dorc_button.dart';
import 'package:dorc_town/graphics/hud_components/dynamic_button.dart';
import 'package:dorc_town/graphics/hud_components/hud_button.dart';
import 'package:dorc_town/recources/asset_class.dart';
import 'package:dorc_town/recources/dorc.dart';
import 'package:dorc_town/structures/structure_component.dart';

import 'package:flame/components.dart';

import 'dart:math';

class Habitat extends StructureComponent {
  var dorcList = <Dorc>[];
  double income = 0;
  double bank = 0;
  int time = -1;
  late DynamicButton collectButton;
  var a = DateTime.now;
  Habitat(super.gridSize);

  @override
  Future<void> onLoad() async {
    sprite = Sprite(game.images.fromCache('habitats/yoghurt_habitat.png'));
    initDorcList();
    hudComponentInit();
    refreshIncome();
    return super.onLoad();
  }

  void refreshIncome() {
    income = 0;
    for (Dorc d in dorcList) {
      income += d.salary;
    }
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
    for (Dorc d in dorcList) {
      hudComponent.addHudButton(
        DorcButton(
          buttonImage: 'experimental/facei.png',
          df: showDorcInfo,
          dorc: d,
        ),
        hudButtonPosition,
        hudSize,
      );
      hudButtonPosition -= Vector2(150, 0);
    }
    hudComponent.addHudButton(
      collectButton = DynamicButton(
        buttonImage: 'experimental/sell.png',
        f: collectAsset,
        habitat: this,
        assetType: AssetType.coins,
      ),
      hudButtonPosition,
      hudSize,
    );
  }

  void initDorcList() {
    var rg = Random().nextInt(4) + 1;
    for (var i = 0; i < rg; i++) {
      dorcList.add(
        Dorc(
            position: Vector2(Random().nextInt(300).toDouble(),
                    100 + Random().nextInt(100).toDouble()) *
                game.psz.mlp),
      );
    }
    for (Dorc d in dorcList) {
      add(d);
      game.dc.addTo(d);
    }
  }

  void showDorcInfo(Dorc dorc) {
    game.targetedDorc = dorc;
    game.overlays.add('DorcInfo');
  }

  @override
  void sellStructure() {
    //can only sell habitat if no dorcs are in it.
    if (dorcList.isNotEmpty) return;
    super.sellStructure();
  }

  void collectAsset() {
    //removes closest lower integer from the bank
    //and moves it into coin asset.
    int toCollect = bank.floor();
    bank -= toCollect;
    game.recources.increaseRecource(toCollect, AssetType.coins);
    collectButton.refreshAsset();
  }

  @override
  void sellDorc() {
    //selling dorc needs to remove it
    // increase coin asset of half its worth.
    removeDorc();
    game.recources.increaseRecource(
        (game.targetedDorc.cost / 2).floor(), AssetType.coins);
  }

  @override
  void update(double dt) {
    //every second bank increases by
    //1/60 of income per min
    if (time == DateTime.now().second) return;
    time = DateTime.now().second;
    bank += income / 60;
    collectButton.refreshAsset();
  }

  void removeDorc() {
    //removing dorc needs to remove it from parent,
    //parent lista and game dc list.
    //habitat need to recalculate income and the
    //hud has to be reimplemented
    dorcList.remove(game.targetedDorc);
    remove(game.targetedDorc);
    game.dc.removeFrom(game.targetedDorc);
    refreshIncome();
    hudComponentInit();
    game.hud.setStructureHud(hudComponent);
  }
}
