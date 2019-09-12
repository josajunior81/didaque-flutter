import 'dart:convert';

import 'package:didaque_flutter/model/apostila.dart';
import 'package:didaque_flutter/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter/services.dart';

class ApostilaDetalhesWidget extends StatefulWidget {
  final int index;

  ApostilaDetalhesWidget(this.index);

  @override
  _ApostilaDetalhesState createState() => _ApostilaDetalhesState();
}

class _ApostilaDetalhesState extends State<ApostilaDetalhesWidget> {
  List<Widget> licoes = [];

  void carregarApostila(var jsonApostilas) async {
    final jsonResponse = json.decode(jsonApostilas);
    Apostila apostila = Apostila.fromJson(jsonResponse);
    licoes.length = 0;
    apostila.licoes.forEach((item) {
      licoes.add(cardLicao(item));
    });
  }

  Widget cardLicao(Licao licao) => SizedBox(
        padding: const EdgeInsets.all(15),
        child: Card(
          child: Column(
            children: [
              Text(licao.titulo,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              ListView.builder(
                  itemCount: licao.catequese.textos.length,
                  itemBuilder: (_, index) {
                    return Text(licao.catequese.textos[index].texto);
                  })
              ],
          ),
        ),
      );

  Future<String> carregarJson() async {
    return await rootBundle.loadString("assets/apostila1.json");
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 1.0; // 1.0 means normal animation speed.

    return FutureBuilder<String>(
      future: carregarJson(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          carregarApostila(snapshot.data);
          return SafeArea(
            child: Material(
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    expandedHeight: 200,
                    backgroundColor: Utils.getColor(widget.index),
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text(Utils.getTitle(widget.index)),
                      centerTitle: true,
                      collapseMode: CollapseMode.parallax,
                      background: Hero(
                        tag: widget.index,
                        child: Image.asset(Utils.getImage(widget.index)),
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (_, index) {
                        if (index > licoes.length - 1) return null;
                        return licoes[index];
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        } else {
          return new CircularProgressIndicator();
        }
      },
    );
  }
}
