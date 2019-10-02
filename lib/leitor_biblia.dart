import 'package:didaque_flutter/model/biblia.dart';
import 'package:flutter/material.dart';

class LeitorBibliaStatefulWidget extends StatefulWidget {
  @override
  _LeitorBibliaStatefulWidgetState createState() =>
      _LeitorBibliaStatefulWidgetState();
}

class _LeitorBibliaStatefulWidgetState
    extends State<LeitorBibliaStatefulWidget> {
  String _livroSelecionado = null;
  int _capituloSelecionado;

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
      debugPrint("page viewport: ${pageController.viewportFraction}");
      if (_controller.offset >= _controller.position.maxScrollExtent) {
        pageController.nextPage(
            duration: Duration(milliseconds: 100),
            curve: Curves.linearToEaseOut);
      } else if (_controller.offset <= _controller.position.minScrollExtent) {
        pageController.nextPage(
            duration: Duration(milliseconds: 100),
            curve: Curves.linearToEaseOut);
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
        )));
  }

  Widget paginaWidget(List<Texto> list) => Container(
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: ListView.builder(
                controller: _controller,
                itemCount: list.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (_, index) {
                  return capituloWidget(list[index]);
                })),
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
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
          ),
        ),
      );
    }
    var conteudo = Container(
      child: Row(
        children: <Widget>[
          Align(
              alignment: Alignment.topLeft,
              child: Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 4.0),
                  child: Text(
                    "${texto.versiculo} ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ))),
          Expanded(
            child: Padding(
                padding: EdgeInsets.only(right: 8.0), child: Text(texto.texto)),
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

class LeitorPageController extends PageController {
  @override
  void jumpTo(double value) {
    // TODO: implement jumpTo
    super.jumpTo(value);
  }

  @override
  Future<void> animateTo(double offset, {Duration duration, Curve curve}) {
    // TODO: implement animateTo
    return super
        .animateTo(offset, duration: Duration(milliseconds: 50), curve: curve);
  }

  @override
  Future<void> animateToPage(int page, {Duration duration, Curve curve}) {
    // TODO: implement animateToPage
    return super.animateToPage(page,
        duration: Duration(milliseconds: 50), curve: curve);
  }

  @override
  void jumpToPage(int page) {
    // TODO: implement jumpToPage
    super.jumpToPage(page);
  }

  @override
  Future<void> nextPage({Duration duration, Curve curve}) {
    // TODO: implement nextPage
    return super.nextPage(duration: Duration(milliseconds: 50), curve: curve);
  }

  @override
  Future<void> previousPage({Duration duration, Curve curve}) {
    debugPrint("${duration}");
    // TODO: implement previousPage
    return super
        .previousPage(duration: Duration(milliseconds: 50), curve: curve);
  }
}
