import 'package:dorc_town/game/dorc_town.dart';
import 'package:flutter/material.dart';

class DorcInfo extends StatelessWidget {
  // Reference to parent game.
  final DorcTown game;
  const DorcInfo({super.key, required this.game});

  //const DorcInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: RowHandler(
        game: game,
      ),
    );
  }
}

class RowHandler extends StatelessWidget {
  final DorcTown game;
  const RowHandler({super.key, required this.game});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          flex: 2,
          child: Container(),
        ),
        Expanded(
          flex: 7,
          child: ColumnHandler(
            game: game,
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(),
        ),
      ],
    );
  }
}

class ColumnHandler extends StatelessWidget {
  final DorcTown game;
  const ColumnHandler({super.key, required this.game});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          flex: 4,
          child: Container(),
        ),
        Expanded(
          flex: 5,
          child: DorcSide(
            game: game,
          ),
        ),
        Expanded(
          flex: 9,
          child: InfoSide(
            game: game,
          ),
        ),
        Expanded(
          flex: 4,
          child: Container(),
        ),
      ],
    );
  }
}

class DorcSide extends StatelessWidget {
  final DorcTown game;
  const DorcSide({super.key, required this.game});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          flex: 6,
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/alpha1.png"),
                fit: BoxFit.cover,
              ),
              color: Color.fromARGB(255, 208, 145, 122),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(),
        ),
      ],
    );
  }
}

class InfoSide extends StatelessWidget {
  final DorcTown game;
  const InfoSide({super.key, required this.game});
  @override
  Widget build(BuildContext context) {
    int salary = game.targetedDorc.salary;
    int cost = game.targetedDorc.cost;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          flex: 2,
          child: InfoSideUpperBar(
            game: game,
          ),
        ),
        Expanded(
          flex: 6,
          child: Container(
            color: Colors.blue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(children: [
                  Text(
                    " Salary: $salary/min",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textScaleFactor: 4,
                  )
                ]),
                Row(children: [
                  Text(
                    " Cost:    $cost coins",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textScaleFactor: 4,
                  )
                ]),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: InfoSideLowerBar(
            game: game,
          ),
        ),
      ],
    );
  }
}

class InfoSideUpperBar extends StatelessWidget {
  final DorcTown game;
  const InfoSideUpperBar({super.key, required this.game});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          flex: 10,
          child: Container(
            color: Colors.purple,
          ),
        ),
        Expanded(
          flex: 2,
          child: InkWell(
            onTap: () {
              game.overlays.remove('DorcInfo');
            },
            child: Image.asset(
              "assets/images/hud/awsome_button_cross.png",
            ),
          ),
        ),
      ],
    );
  }
}

class InfoSideLowerBar extends StatelessWidget {
  final DorcTown game;
  const InfoSideLowerBar({super.key, required this.game});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          flex: 5,
          child: Container(
            color: Colors.green,
          ),
        ),
        Expanded(
          flex: 4,
          child: Container(
            color: Colors.purple,
          ),
        ),
        Expanded(
          flex: 3,
          child: InkWell(
            onTap: () {},
            child: Image.asset(
              "assets/images/hud/move_button.png",
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: InkWell(
            onTap: () {
              game.ts.current.sellDorc();
              game.overlays.remove('DorcInfo');
            },
            child: Image.asset(
              "assets/images/experimental/sell.png",
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: InkWell(
            onTap: () {},
            child: Image.asset(
              "assets/images/shop/building_button.png",
            ),
          ),
        ),
      ],
    );
  }
}
