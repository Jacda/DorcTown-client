import 'package:dorc_town/game/dorc_town.dart';
import 'package:flutter/material.dart';

class Market extends StatelessWidget {
  // Reference to parent game.
  final DorcTown game;

  const Market({super.key, required this.game});

  double scaleType(double width, double height) {
    if ((height * 1.777777) < width) return height * 2;
    return width * 1.125;
  }

  @override
  Widget build(BuildContext context) {
    double scalewidth = MediaQuery.of(context).size.width * 0.15;
    double scaleheigth = MediaQuery.of(context).size.height * 0.15;
    double scale = scaleType(scalewidth, scaleheigth);
    double widthGap = scale * 0.4;
    double heightGap = scale * 0.15;

    return Material(
      color: Colors.transparent,
      child: Center(
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/shop/market.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          game.overlays.remove('Market');
                        },
                        child: Image.asset(
                          "assets/images/shop/building_button.png",
                          height: scale,
                          width: scale,
                        ),
                      ),
                      SizedBox(width: widthGap),
                      InkWell(
                        onTap: () {
                          game.overlays.remove('Market');
                        },
                        child: Image.asset(
                          "assets/images/shop/dorc_button.png",
                          height: scale,
                          width: scale,
                        ),
                      ),
                      SizedBox(width: widthGap),
                      InkWell(
                        onTap: () {
                          game.buyStructure();
                        },
                        child: Image.asset(
                          "assets/images/shop/habitat_button.png",
                          height: scale,
                          width: scale,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: heightGap),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          game.overlays.remove('Market');
                        },
                        child: Image.asset(
                          "assets/images/shop/building_button.png",
                          height: scale,
                          width: scale,
                        ),
                      ),
                      SizedBox(width: widthGap),
                      InkWell(
                        onTap: () {
                          game.ts.breedingCave = true;
                          game.buyStructure();
                        },
                        child: Image.asset(
                          "assets/images/shop/dorc_button.png",
                          height: scale,
                          width: scale,
                        ),
                      ),
                      SizedBox(width: widthGap),
                      InkWell(
                        onTap: () {
                          game.overlays.remove('Market');
                        },
                        child: Image.asset(
                          "assets/images/shop/habitat_button.png",
                          height: scale,
                          width: scale,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
