class Apostila {
  final int numeroLicao;
  final String tituloApostila;
  final String tituloLicao;
  final String catequese;
  final int numeroApostila;

  Apostila(
      {this.numeroLicao,
      this.tituloApostila,
      this.tituloLicao,
      this.catequese,
      this.numeroApostila});

  Apostila.fromJson(Map<String, dynamic> data)
      : numeroLicao = data['numeroLicao'],
        tituloApostila = data['tituloApostila'],
        tituloLicao = data['tituloLicao'],
        catequese = data['catequese'],
        numeroApostila = data['numeroApostila'];
}

class ApostilasList {
  final List<Apostila> apositlas;

  ApostilasList({this.apositlas});

  ApostilasList.fromJson(List<dynamic> data) : apositlas = data.map((i) => Apostila.fromJson(i)).toList();
}
