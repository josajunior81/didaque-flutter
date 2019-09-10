import 'package:didaque_flutter/apostilas.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class ApostilaDetalhesWidget extends StatefulWidget {
  final String title;
  final int index;

  ApostilaDetalhesWidget(this.title, this.index);

  @override
  _ApostilaDetalhesState createState() => _ApostilaDetalhesState();
}

class _ApostilaDetalhesState extends State<ApostilaDetalhesWidget> {
  @override
  Widget build(BuildContext context) {
    timeDilation = 5.0; // 1.0 means normal animation speed.

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: SizedBox.expand(
          child: Hero(
            tag: 0,
            child: Image.asset(
              "images/apostila${(widget.index + 1)}.webp",
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
