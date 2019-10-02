import 'package:didaque_flutter/helpers/database_helper.dart';

class Biblia {
  final int id;
  final String versao;
  final String dam_id;
  final String titulo_completo;
  final String copyright;
  final String url;
  List<Texto> textos;

  Biblia(
      {this.id,
      this.versao,
      this.dam_id,
      this.titulo_completo,
      this.copyright,
      this.url});

  Map<String, dynamic> toMap() => {
        'id': id,
        'versao': versao,
        'dam_id': dam_id,
        'titulo_completo': titulo_completo,
        'copyright': copyright,
        'url': url
      };

  Future<List<Biblia>> getBiblias() async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query("biblia");
    return List.generate(maps.length, (i) {
      return Biblia(
        id: maps[i]['id'],
        copyright: maps[i]['copyright'],
        titulo_completo: maps[i]['titulo_completo'],
        url: maps[i]['url'],
        versao: maps[i]['versao'],
      );
    });
  }
}

class Texto {
  final int id;
  final int ordem;
  final String titulo;
  final String sigla;
  final int capitulo;
  final int versiculo;
  final String texto;
  final int biblia_id;

  Texto(
      {this.id,
      this.ordem,
      this.titulo,
      this.sigla,
      this.capitulo,
      this.versiculo,
      this.texto,
      this.biblia_id});

  Map<String, dynamic> toMap() => {
        "ordem": ordem,
        "titulo": titulo,
        "sigla": sigla,
        "capitulo": capitulo,
        "versiculo": versiculo,
        "texto": texto
      };

  static Future<List<String>> getLivros() async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db
        .rawQuery("SELECT titulo FROM texto GROUP BY ordem ORDER BY ordem");
    return List.generate(maps.length, (i) {
      return maps[i]['titulo'];
    });
  }

  static Future<List<int>> getCapitulos(String _livroSelecionado) async {
    final db = await DatabaseHelper.instance.database;
    _livroSelecionado =
        _livroSelecionado == null ? 'Gênesis' : _livroSelecionado;
    final List<Map<String, dynamic>> maps = await db.rawQuery(
        "SELECT capitulo FROM texto WHERE titulo = '${_livroSelecionado}' GROUP BY capitulo ORDER BY capitulo");
    return List.generate(maps.length, (i) {
      return maps[i]['capitulo'];
    });
  }

  static Future<List<Texto>> getTexto(
      String _livroSelecionado, int capitulo) async {
    final db = await DatabaseHelper.instance.database;

    _livroSelecionado =
        _livroSelecionado == null ? 'Gênesis' : _livroSelecionado;

    final List<Map<String, dynamic>> maps = await db.rawQuery(
        "SELECT ordem, titulo, capitulo, versiculo, texto FROM texto WHERE titulo = '${_livroSelecionado}' AND capitulo = '${capitulo}'");

    return List.generate(maps.length, (i) {
      return Texto(
          ordem: maps[i]['ordem'],
          titulo: maps[i]['titulo'],
          capitulo: maps[i]['capitulo'],
          versiculo: maps[i]['versiculo'],
          texto: maps[i]['texto']
      );
    });
  }
}
