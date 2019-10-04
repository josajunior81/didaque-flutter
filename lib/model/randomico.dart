class Randomico {
  final String texto;

  Randomico({this.texto});

  Randomico.fromJson(Map<String, dynamic> data) : texto = data['texto'];
}

class ListRandomico {
  final List<Randomico> randomicos;

  ListRandomico({this.randomicos});

  ListRandomico.fromJson(List<dynamic> data)
      : randomicos = data.map((d) => Randomico.fromJson(d)).toList();
}
