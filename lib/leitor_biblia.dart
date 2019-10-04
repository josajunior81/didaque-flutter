import 'package:didaque_flutter/model/biblia.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class LeitorBibliaStatefulWidget extends StatefulWidget {
  @override
  _LeitorBibliaStatefulWidgetState createState() =>
      _LeitorBibliaStatefulWidgetState();
}

class _LeitorBibliaStatefulWidgetState
    extends State<LeitorBibliaStatefulWidget> {
  String _livroSelecionado = null;
  int _capituloSelecionado;
  bool mostarBottomBar = true;

  double textFontSize = 15.0;

  PageController pageController;

  var currentPage;

  List<int> listCapitulos;

  List<String> listLivros;
  List<String> listSiglas;

  ScrollController _controller;

  @override
  void initState() {
    pageController = new LeitorPageController();
//    pageController.jumpToPage(0.0);
    currentPage = 0.0;
    _capituloSelecionado = 1;
    _livroSelecionado = "Gênesis";
    _controller = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    pageController.addListener(() {
      setState(() {
        currentPage = pageController.page;
      });
    });

//    _controller.addListener(() {
//      if (_controller.position.userScrollDirection == ScrollDirection.forward) {
//        setState(() {
//          mostarBottomBar = false;
//        });
//      } else if (_controller.position.userScrollDirection ==
//          ScrollDirection.reverse) {
//        setState(() {
//          mostarBottomBar = true;
//        });
//      }
//    });

    carregarCapitulos() async {
      listCapitulos = await Texto.getCapitulos(_livroSelecionado);
      return listCapitulos;
    }

    carregarLivros() async {
      var listLivros = await Texto.getLivros();
      listSiglas = listLivros.map((livro) {
        if (double.tryParse(livro.substring(0, 1)) != null) {
          return livro.substring(0, 4);
        } else if (livro.length < 3) {
          return livro;
        } else
          return livro.substring(0, 3);
      }).toList();
      return listLivros;
    }

    carregarLivro() async => (_capituloSelecionado == 1)
        ? await Texto.getTexto(_livroSelecionado, 1)
        : await Texto.getTexto(
            _livroSelecionado, (pageController.page.floor() + 1));

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, false),
        ),
        backgroundColor: Colors.grey[700],
        actions: <Widget>[
          FutureBuilder<List<String>>(
              future: carregarLivros(),
              builder: (context, snapshot) {
                return (snapshot.hasData)
                    ? Theme(
                        data: Theme.of(context).copyWith(
                          canvasColor: Colors.grey[700],
                        ),
                        child: DropdownButton(
                            style: TextStyle(color: Colors.white, fontSize: 15),
                            icon: Icon(Icons.arrow_downward),
                            iconSize: 15,
                            iconEnabledColor: Colors.white,
                            underline: Container(
                              height: 1,
                              color: Colors.white,
                            ),
                            items: snapshot.data
                                .map((texto) => DropdownMenuItem<String>(
                                      child: Text(texto),
                                      value: texto,
                                    ))
                                .toList(),
                            onChanged: (texto) => setState(() {
                                  _livroSelecionado = texto;
                                  _capituloSelecionado = 1;
                                  pageController.jumpToPage(0);
                                  _controller.jumpTo(0.0);
                                }),
                            value: _livroSelecionado != null
                                ? _livroSelecionado
                                : snapshot.data.first))
                    : new Center(child: new CircularProgressIndicator());
              }),
          FutureBuilder<List<int>>(
              future: carregarCapitulos(),
              builder: (context, snapshot) {
                return (snapshot.hasData)
                    ? Theme(
                        data: Theme.of(context).copyWith(
                          canvasColor: Colors.grey[700],
                        ),
                        child: DropdownButton(
                            style: TextStyle(color: Colors.white, fontSize: 15),
                            icon: Icon(Icons.arrow_downward),
                            iconSize: 15,
                            iconEnabledColor: Colors.white,
                            underline: Container(
                              height: 1,
                              color: Colors.white,
                            ),
                            items: snapshot.data
                                .map((capitulo) => DropdownMenuItem<int>(
                                      child: Text("${capitulo}"),
                                      value: capitulo,
                                    ))
                                .toList(),
                            onChanged: (int cap) => setState(() {
                                  _capituloSelecionado = cap;
                                  pageController.jumpToPage(cap - 1);
                                  _controller.jumpTo(0.0);
                                }),
                            value: _capituloSelecionado != null
                                ? _capituloSelecionado
                                : snapshot.data.first))
                    : new Center(child: new CircularProgressIndicator());
              }),
//          IconButton(
//            icon: Icon(Icons.settings),
//            onPressed: () {
//              debugPrint("config");
//            },
//          ),
        ],
      ),
      body: SafeArea(
          child: Container(
              child: FutureBuilder<List<Texto>>(
        future: carregarLivro(),
        builder: (context, snapshot) {
          return (snapshot.hasData)
              ? PageView.builder(
                  controller: pageController,
                  physics: NeverScrollableScrollPhysics(),
                  pageSnapping: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, position) {
                    var stack = Stack(
                      children: <Widget>[
                        paginaWidget(snapshot.data),
                        Positioned(
                          top: MediaQuery.of(context).size.height / 2,
                          left: 5,
                          child: Offstage(
                              offstage: mostarBottomBar,
                              child: FloatingActionButton(
                                backgroundColor: Colors.grey[700],
                                onPressed: (() {
                                  setState(() {
                                    if (_capituloSelecionado > 1) {
                                      _capituloSelecionado -= 1;
                                      pageController
                                          .jumpToPage(_capituloSelecionado - 1);
                                      _controller.jumpTo(0.0);
                                    }
                                  });
                                }),
                                child: Icon(Icons.arrow_back_ios),
                              )),
                        ),
                        Positioned(
                          top: MediaQuery.of(context).size.height / 2,
                          right: 5,
                          child: Offstage(
                              offstage: mostarBottomBar,
                              child: FloatingActionButton(
                                backgroundColor: Colors.grey[700],
                                onPressed: (() {
                                  setState(() {
                                    if (_capituloSelecionado <
                                        listCapitulos.length) {
                                      _capituloSelecionado += 1;
                                      pageController
                                          .jumpToPage(_capituloSelecionado - 1);
                                    }
                                  });
                                }),
                                child: Icon(Icons.arrow_forward_ios),
                              )),
                        )
                      ],
                    );
                    return stack;
                  },
                )
              : new Center(child: new CircularProgressIndicator());
        },
      ))),
    );
  }

  Widget paginaWidget(List<Texto> list) => Container(
        child: Padding(
          padding: EdgeInsets.only(top: 5.0),
          child: Column(
            children: <Widget>[
              Expanded(
                  child: ListView.builder(
                      controller: _controller,
                      itemCount: list.length,
//                physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (_, index) {
                        return GestureDetector(
                            onTap: () => setState(
                                () => mostarBottomBar = !mostarBottomBar),
                            child: capituloWidget(list[index]));
                      })),
            ],
          ),
        ),
      );

  double getOpacity() => mostarBottomBar ? 0.0 : 1.0;

  Widget capituloWidget(Texto texto) {
    var titulo = null;
    if (texto.versiculo == 1) {
      titulo = Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: EdgeInsets.only(left: 8.0, top: 10.0, bottom: 4.0),
          child: Text(
            "Capítulo ${texto.capitulo}",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: textFontSize * 1.5),
          ),
        ),
      );
    }
    var conteudo = Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
                padding: EdgeInsets.only(left: 8.0, right: 5.0, top: 5.0),
                child: Text(
                  "${texto.versiculo} ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: textFontSize * 0.8),
                )),
          ),
          Expanded(
            child: Padding(
                padding: EdgeInsets.only(right: 8.0, top: 5.0),
                child: Text(
                  texto.texto,
                  style: TextStyle(fontSize: textFontSize),
                )),
          ),
//            Divider(color: Colors.grey[700])
        ],
      ),
    );

    return titulo != null
        ? Column(
            children: <Widget>[titulo, conteudo],
          )
        : conteudo;
  }
}

class LeitorPageController extends PageController {}
