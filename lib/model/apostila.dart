class Apostila {
  final int numero;
  final String titulo;
  final String idioma;
  final List<Licao> licoes;

  Apostila(
      {this.numero,
      this.titulo,
      this.idioma,
      this.licoes});

  Apostila.fromJson(Map<String, dynamic> data)
      : numero = data['numero'],
        titulo = data['titulo'],
        idioma = data['idioma'],
        licoes = data['licoes'];
}

class Licao {
  final int licao;
  final String titulo;
  final Catequese catequese;

  Licao({this.licao, this.titulo, this.catequese});

  Licao.fromJson(Map<String, dynamic> data)
      : licao = data['licao'],
        titulo = data['titulo'],
        catequese = data['catequese'];
}

class Catequese {
  final List<Pergunta> perguntas;
  final List<Texto> textos;

  Catequese({this.perguntas, this.textos});

  Catequese.fromJson(Map<String, dynamic> data)
      : perguntas = data['perguntas'],
        textos = data['textos'];
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