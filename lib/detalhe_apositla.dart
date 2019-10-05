import 'dart:convert';

import 'package:didaque_flutter/model/apostila.dart';
import 'package:didaque_flutter/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter/services.dart';
import 'package:share/share.dart';

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

  Widget buildTextos(Catequese catequese) {
    var textos = catequese.textos;
    var perguntas = catequese.perguntas;

    var column = Column(
      children: <Widget>[],
    );

    perguntas.forEach((p) => column.children.add(Container(
            child: Column(children: [
          Padding(
              padding: EdgeInsets.only(top: 5.0, left: 12.0, right: 12.0),
              child: Text(p.pergunta,
                  style: TextStyle(fontWeight: FontWeight.bold))),
          Padding(
              padding: EdgeInsets.only(bottom: 15.0, left: 12.0, right: 12.0),
              child: Text(p.resposta != null ? p.resposta : "",
                  style: TextStyle(fontStyle: FontStyle.italic)))
        ]))));

    textos.forEach((t) => column.children.add(Container(
            child: Column(children: [
          Padding(
              padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 12.0),
              child: Text(t.texto)),
          Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                  alignment: Alignment.bottomRight, child: Text(t.referencia)))
        ]))));

    return column;
  }

  Widget cardLicao(Licao licao) => Container(
        child: Card(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(licao.titulo,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: PopupMenuButton(
                        onSelected: (context) {
                          setState(() {
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    'Esse recurso estará disponível em breve!')));
                          });
                        },
                        itemBuilder: (_) => [
                              PopupMenuItem(
                                child: Row(children: [
                                  IconButton(
                                    icon: Icon(Icons.share),
                                    onPressed: () {
                                      setState(() {
                                        Share.share("${licao.catequese.textos[0].texto}");
                                      });
                                    },
                                  )
                                ]),
                              )
                            ]),
                  ),
                ],
              ),
              Container(
                child: buildTextos(licao.catequese),
              ),
            ],
          ),
        ),
      );

  Future<String> carregarJson() async {
    return await rootBundle
        .loadString("assets/apostila${widget.index + 1}.json");
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
