import 'package:didaque_flutter/model/biblia.dart';
import 'package:flutter/material.dart';

class LeitorBibliaStatefulWidget extends StatefulWidget {
  @override
  _LeitorBibliaStatefulWidgetState createState() =>
      _LeitorBibliaStatefulWidgetState();
}

class _LeitorBibliaStatefulWidgetState
    extends State<LeitorBibliaStatefulWidget> {
  String _livroSelecionado = null;
  int _capituloSelecionado = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Image(image: AssetImage("images/icon.png")),
          backgroundColor: Colors.red[300],
          actions: <Widget>[
            FutureBuilder<List<String>>(
                future: Texto.getLivros(),
                builder: (context, snapshot) {
                  return (snapshot.hasData)
                      ? DropdownButton(
                          items: snapshot.data
                              .map((texto) => DropdownMenuItem<String>(
                                    child: Text(texto),
                                    value: texto,
                                  ))
                              .toList(),
                          onChanged: (texto) =>
                              setState(() => _livroSelecionado = texto),
                          value: _livroSelecionado != null
                              ? _livroSelecionado
                              : snapshot.data.first)
                      : new Center(child: new CircularProgressIndicator());
                }),
            FutureBuilder<List<int>>(
                future: Texto.getCapitulos(_livroSelecionado),
                builder: (context, snapshot) {
                  return (snapshot.hasData)
                      ? DropdownButton(
                          items: snapshot.data
                              .map((capitulo) => DropdownMenuItem<int>(
                                    child: Text("${capitulo}"),
                                    value: capitulo,
                                  ))
                              .toList(),
                          onChanged: (texto) =>
                              setState(() => _capituloSelecionado = texto),
                          value: _capituloSelecionado != null
                              ? _capituloSelecionado
                              : snapshot.data.first)
                      : new Center(child: new CircularProgressIndicator());
                }),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                debugPrint("config");
              },
            ),
          ],
        ),
        body: Container(child: Column(children: [])));
  }
}
