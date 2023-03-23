import 'package:flutter/material.dart';
import 'package:dorc_town/blueprints/blueprints.dart';

void main() {
  runApp(const TestApp());
}

class TestApp extends StatelessWidget {
  const TestApp({super.key});

  void testFunction() {
    LoadDorcs();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            FloatingActionButton(onPressed: () => testFunction()),
          ],
        ),
      ),
    );
  }
}
