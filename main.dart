import 'package:dorc_town/graphics/overlays/dorc_info.dart';
import 'package:dorc_town/graphics/overlays/market.dart';
import 'package:flame/flame.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:dorc_town/game/dorc_town.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  Flame.device.setLandscape();
  runApp(
    MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
      home: GameWidget<DorcTown>.controlled(
        gameFactory: DorcTown.new,
        overlayBuilderMap: {
          'Market': (_, game) => Market(game: game),
          'DorcInfo': (_, game) => DorcInfo(game: game),
        },
      ),
    ),
  );
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}
