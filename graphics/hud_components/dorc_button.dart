import 'package:dorc_town/graphics/hud_components/hud_button.dart';
import 'package:dorc_town/recources/dorc.dart';

import 'package:flame/events.dart';

class DorcButton extends HudButton {
  late Dorc dorc;
  late Function(Dorc) df;

  DorcButton({
    required super.buttonImage,
    required this.df,
    required this.dorc,
  }) : super(f: emptyFunc);

  @override
  bool onTapDown(TapDownInfo info) {
    df(dorc);
    info.handled = true;
    return true;
  }

  static void emptyFunc() {}
}
