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

  PageController pageController;

  var currentPage;

  List<int> listCapitulos;

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

    _controller.addListener(() {
      if (_controller.position.userScrollDirection == ScrollDirection.forward) {
        setState(() {
          mostarBottomBar = true;
        });
      } else if (_controller.position.userScrollDirection ==
          ScrollDirection.reverse) {
        setState(() {
          mostarBottomBar = false;
        });
      }

      if (_controller.offset >= _controller.position.maxScrollExtent &&
          !_controller.position.outOfRange) {
        setState(() {
          mostarBottomBar = true;
        });
      } else if (_controller.offset <= _controller.position.minScrollExtent &&
          !_controller.position.outOfRange) {
//        mostarBottomBar = true;
      }
    });

    carregarCapitulos() async {
      listCapitulos = await Texto.getCapitulos(_livroSelecionado);
      return listCapitulos;
    }

    carregarLivro() async => (_capituloSelecionado == 1)
        ? await Texto.getTexto(_livroSelecionado, 1)
        : await Texto.getTexto(
            _livroSelecionado, (pageController.page.floor() + 1));

    return Scaffold(
      appBar: AppBar(
        leading: Image(image: AssetImage("images/icon.png")),
        backgroundColor: Colors.red[300],
        actions: <Widget>[
          FutureBuilder<List<String>>(
              future: Texto.getLivros(),
              builder: (context, snapshot) {
                return (snapshot.hasData)
                    ? DropdownButton(
                        items: snapshot.data
                            .map((texto) => DropdownMenuItem<String>(
                                  child: Text(texto),
                                  value: texto,
                                ))
                            .toList(),
                        onChanged: (texto) =>
                            setState(() => _livroSelecionado = texto),
                        value: _livroSelecionado != null
                            ? _livroSelecionado
                            : snapshot.data.first)
                    : new Center(child: new CircularProgressIndicator());
              }),
          FutureBuilder<List<int>>(
              future: carregarCapitulos(),
              builder: (context, snapshot) {
                return (snapshot.hasData)
                    ? DropdownButton(
                        items: snapshot.data
                            .map((capitulo) => DropdownMenuItem<int>(
                                  child: Text("${capitulo}"),
                                  value: capitulo,
                                ))
                            .toList(),
                        onChanged: (int cap) => setState(() {
                              _capituloSelecionado = cap;
                              pageController.jumpToPage(cap - 1);
                            }),
                        value: _capituloSelecionado != null
                            ? _capituloSelecionado
                            : snapshot.data.first)
                    : new Center(child: new CircularProgressIndicator());
              }),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              debugPrint("config");
            },
          ),
        ],
      ),
      body: Container(
          child: FutureBuilder<List<Texto>>(
        future: carregarLivro(),
        builder: (context, snapshot) {
          return (snapshot.hasData)
              ? PageView.builder(
                  controller: pageController,
                  physics: NeverScrollableScrollPhysics(),
                  pageSnapping: false,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index) {
                    _capituloSelecionado = index + 1;
                  },
                  itemBuilder: (_, position) {
//          _capituloSelecionado = position + 1
                    return paginaWidget(snapshot.data);
                  },
                )
              : new Center(child: new CircularProgressIndicator());
        },
      )),
    );
  }

  Widget paginaWidget(List<Texto> list) => Container(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            children: <Widget>[
              Expanded(
                  child: ListView.builder(
                      controller: _controller,
                      itemCount: list.length,
//                physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (_, index) {
                        return capituloWidget(list[index]);
                      })),
              Visibility(
                visible: mostarBottomBar,
                child: AnimatedOpacity(
                  opacity: mostarBottomBar ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 3500),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FloatingActionButton(
                        backgroundColor: Colors.grey[700],
                        onPressed: (() {}),
                        child: Icon(Icons.arrow_back_ios),
                      ),
                      Text(_livroSelecionado != null
                          ? "${_livroSelecionado} ${_capituloSelecionado}"
                          : ""),
                      FloatingActionButton(
                        backgroundColor: Colors.grey[700],
                        onPressed: (() {}),
                        child: Icon(Icons.arrow_forward_ios),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );

  Widget capituloWidget(Texto texto) {
    var titulo = null;
    if (texto.versiculo == 1) {
      titulo = Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: EdgeInsets.only(left: 8.0, top: 10.0, bottom: 4.0),
          child: Text(
            "Capítulo ${texto.capitulo}",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
          ),
        ),
      );
    }
    var conteudo = Container(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Align(
              alignment: Alignment.topLeft,
              child: Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 4.0),
                  child: Text(
                    "${texto.versiculo} ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ))),
          Expanded(
            child: Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Text(
                  texto.texto,
                  style: TextStyle(fontSize: 20),
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
