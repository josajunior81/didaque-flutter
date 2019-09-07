import 'package:flutter/material.dart';

class BibliaWidget extends StatelessWidget {
  static const String _title = 'Bíblia';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Text("Bíblia"),
    );
  }
}