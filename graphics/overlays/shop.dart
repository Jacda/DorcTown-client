import 'package:flutter/material.dart';
import 'dart:ui';

class Shop extends StatelessWidget {
  // Reference to parent game.
  //final DorcTown game;
  //const Shop({super.key, required this.game});

  const Shop({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      home: const RowHandler(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RowHandler extends StatelessWidget {
  const RowHandler({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Title(),
        Container(
          height: 500,
          child: const ScrollPage(),
        ),
        const Footer(),
      ],
    );
  }
}

class Title extends StatelessWidget {
  const Title({super.key});
  @override
  Widget build(BuildContext context) {
    return const Text("Dorcs");
  }
}

class Footer extends StatelessWidget {
  const Footer({super.key});
  @override
  Widget build(BuildContext context) {
    return const Text("Filter");
  }
}

class ScrollPage extends StatelessWidget {
  const ScrollPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: 4,
      scrollDirection: Axis.horizontal,
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          width: 400,
          //color: Colors.amber[colorCodes[index]],
          color: Colors.blue,
          child: const Center(child: Merchandise()),
        );
      },
    );
  }
}

class Merchandise extends StatelessWidget {
  const Merchandise({super.key});
  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          print("hello");
        },
        child: Container(
          height: 400,
          width: 300,
          color: Colors.green,
          child: Column(
            children: [
              const Text("Tewe", textScaleFactor: 2.0),
              const Text(
                "5,000",
                textScaleFactor: 1.8,
              ),
              Container(
                child: Image.asset(
                  'assets/images/alpha1.png',
                  height: 200,
                  fit: BoxFit.cover,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
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
