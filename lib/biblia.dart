import 'dart:convert';
import 'package:didaque_flutter/model/livro.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
      return GridView.builder(
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: livros.length),
          itemBuilder: (BuildContext context, int index) {
            return Text(livros[index].abbrev);
          });
    }

    return new FutureBuilder<Livros>(
        future: carregarLivros(),
        builder: (context, snapshot) {
          return (snapshot.hasData)
              ? gridViewLivros(snapshot.data.livros)
              : new Center(child: new CircularProgressIndicator());
        });
  }
}
