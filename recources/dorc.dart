import 'dart:math';
import 'package:dorc_town/game/dorc_town.dart';
import 'package:dorc_town/recources/asset_class.dart';
import 'package:flame/components.dart';

class Dorc extends SpriteComponent with HasGameRef<DorcTown> {
  late AssetType assetType;
  late int salary;
  late int cost;

  Dorc({
    required super.position,
  }) : super(size: Vector2.all(128)) {
    salary = Random().nextInt(10) + 10;
    cost = 100;
    assetType = AssetType.coins;
  }

  @override
  Future<void> onLoad() async {
    sprite = Sprite(game.images.fromCache("alpha1.png"));
  }
}
