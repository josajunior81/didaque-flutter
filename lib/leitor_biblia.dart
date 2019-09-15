import 'package:didaque_flutter/model/livro.dart';
import 'package:flutter/material.dart';

class LeitorBibliaStatefulWidget extends StatefulWidget {
  final List<Livro> livros;
  final int index;
  LeitorBibliaStatefulWidget(this.livros, this.index);

  @override
  _LeitorBibliaStatefulWidgetState createState() =>
      _LeitorBibliaStatefulWidgetState();
}

class _LeitorBibliaStatefulWidgetState
    extends State<LeitorBibliaStatefulWidget> {
  Future<Livro> carregarLivro() {}

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
        future: carregarLivro(),
        builder: (context, snapshot) {
          return (snapshot.hasData)
              ? PageView.builder(itemBuilder: (_, index) {})
              : new Center(child: new CircularProgressIndicator());
        });
  }
}
