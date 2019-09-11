import 'package:didaque_flutter/apostilas.dart';
import 'package:didaque_flutter/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class ApostilaDetalhesWidget extends StatefulWidget {
  final int index;

  ApostilaDetalhesWidget(this.index);

  @override
  _ApostilaDetalhesState createState() => _ApostilaDetalhesState();
}

class _ApostilaDetalhesState extends State<ApostilaDetalhesWidget> {
  @override
  Widget build(BuildContext context) {
    timeDilation = 5.0; // 1.0 means normal animation speed.

    return Scaffold(
      appBar: AppBar(
        title: Text(Utils.getTitle(widget.index)),
        backgroundColor: Utils.getColor(widget.index),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: SizedBox.expand(
          child: Hero(
            tag: widget.index,
            child: Image.asset(
              Utils.getTitle(widget.index),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
