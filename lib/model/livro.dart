class Livro {
  final String abbrev;
  final String author;
  final int chapters;
  final String group;
  final String name;
  final String testament;

  Livro(
      {this.abbrev,
      this.author,
      this.chapters,
      this.group,
      this.name,
      this.testament});

  Livro.fromJson(Map<String, dynamic> data)
      : abbrev = data['abbrev'],
        author = data['author'],
        chapters = data['chapters'],
        group = data['group'],
        name = data['name'],
        testament = data['testament'];
}

class Livros {
  final List<Livro> livros;

  Livros({this.livros});

  Livros.fromJson(List<dynamic> data)
      : livros = data.map((i) => Livro.fromJson(i)).toList();
}
