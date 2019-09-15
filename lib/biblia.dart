import 'dart:convert';
import 'package:didaque_flutter/model/livro.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'leitor_biblia.dart';

class BibliaStatefulWidget extends StatefulWidget {
  BibliaStatefulWidget({Key key}) : super(key: key);

  @override
  _BibliaStatefulWidgetState createState() => _BibliaStatefulWidgetState();
}

class _BibliaStatefulWidgetState extends State<BibliaStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    Future<Livros> carregarLivros() async {
      final response = await http.get('https://bibleapi.co/api/books/');

      if (response.statusCode == 200) {
        // If server returns an OK response, parse the JSON.
        return Livros.fromJson(json.decode(response.body));
      } else {
        // If that response was not OK, throw an error.
        throw Exception('Failed to load post');
      }
    }

    Widget gridViewLivros(List<Livro> livros) {
      return Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
          child: GridView.builder(
              itemCount: livros.length,
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6),
              itemBuilder: (BuildContext context, int index) {
                return Material(
                    child: InkWell(
                        onTap: () => { _abrirVersiculos(context, livros, index)},
                        child: Container(
                            decoration: const BoxDecoration(
                                border: Border(
                              top: BorderSide(width: 1.0, color: Colors.black),
                              left: BorderSide(width: 1.0, color: Colors.black),
                              right:
                                  BorderSide(width: 1.0, color: Colors.black),
                              bottom:
                                  BorderSide(width: 1.0, color: Colors.black),
                            )),
                            child: Center(
                                child: Text(
                                    livros[index].abbrev.toUpperCase())))));
              }));
    }

    return new FutureBuilder<Livros>(
        future: carregarLivros(),
        builder: (context, snapshot) {
          return (snapshot.hasData)
              ? gridViewLivros(snapshot.data.livros)
              : new Center(child: new CircularProgressIndicator());
        });
  }

  _abrirVersiculos(BuildContext context, List<Livro> livros, int index) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return LeitorBibliaStatefulWidget(livros, index);
    }));
  }
}
