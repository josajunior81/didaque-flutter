class Apostila {
  final int numero;
  final String titulo;
  final String idioma;
  final List<Licao> licoes;

  Apostila({this.numero, this.titulo, this.idioma, this.licoes});

  factory Apostila.fromJson(Map<String, dynamic> data) {
    var l = data['licoes'] as List;
    List<Licao> listLicao = l.map((i) => Licao.fromJson(i)).toList();
    return Apostila(
        numero: data['numero'],
        titulo: data['titulo'],
        idioma: data['idioma'],
        licoes: listLicao);
  }
}

class Licao {
  final int licao;
  final String titulo;
  final Catequese catequese;

  Licao({this.licao, this.titulo, this.catequese});

  Licao.fromJson(Map<String, dynamic> data)
      : licao = data['licao'],
        titulo = data['titulo'],
        catequese = Catequese.fromJson(data['catequese']);
}

class Catequese {
  final List<Pergunta> perguntas;
  final List<Texto> textos;

  Catequese({this.perguntas, this.textos});

  factory Catequese.fromJson(Map<String, dynamic> data) {
    var p = data['perguntas'] as List;
    var t = data['textos'] as List;

    List<Pergunta> listPerguntas =
        p != null ? p.map((i) => Pergunta.fromJson(i)).toList() : new List();
    List<Texto> listTextos =
        t != null ? t.map((i) => Texto.fromJson(i)).toList() : new List();

    return Catequese(perguntas: listPerguntas, textos: listTextos);
  }
}

class Pergunta {
  final String pergunta;
  final String resposta;

  Pergunta({this.pergunta, this.resposta});

  Pergunta.fromJson(Map<String, dynamic> data)
      : pergunta = data['pergunta'],
        resposta = data['resposta'];
}

class Texto {
  final String texto;
  final String referencia;

  Texto({this.texto, this.referencia});

  Texto.fromJson(Map<String, dynamic> data)
      : texto = data['texto'],
        referencia = data['referencia'];
}
