import 'dart:convert';
import 'dart:math';

import 'package:didaque_flutter/model/randomico.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InicioStatefullWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return InicioState();
  }
}

class InicioState extends State {
  Future<String> carregarJson() async {
    return await rootBundle.loadString("assets/randomicos.json");
  }

  carregarTextoRandomico(var jsonRand) {
    final jsonResponse = json.decode(jsonRand);
    ListRandomico randomicos = ListRandomico.fromJson(jsonResponse);
    var _random = new Random();
    var list = randomicos.randomicos;
    return Center(
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            list[_random.nextInt(list.length)].texto,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder(
      future: carregarJson(),
      builder: (_, snapshot) {
        return (snapshot.hasData)
            ? carregarTextoRandomico(snapshot.data)
            : CircularProgressIndicator();
      },
    );
  }
}
