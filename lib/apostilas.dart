import 'package:didaque_flutter/detalhe_apositla.dart';
import 'package:flutter/material.dart';

class ApostilasWidget extends StatelessWidget {
  const ApostilasWidget({Key key, this.photo, this.onTap, this.width})
      : super(key: key);

  final String photo;
  final VoidCallback onTap;
  final double width;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        listItem(0, context),
        listItem(1, context),
        listItem(2, context),
        listItem(3, context),
        listItem(4, context)
      ],
    );
  }

  void showDetails(int index, BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ApostilaDetalhes(getTitle(index));
    }));
  }

  Widget listItem(int position, BuildContext context) => Hero(
        tag: getTitle(position),
        child: Material(
          child: InkWell(
            onTap: () => showDetails(position, context),
            child: Container(
              height: 150.0,
              color: getColor(position),
              child: Row(
                children: [
                  Image.asset(getImage(position)),
                  Expanded(
                    child: Center(
                      child: Text(
                        getTitle(position),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  Color getColor(int index) {
    switch (index) {
      case 0:
        return Colors.blueGrey[300];
      case 1:
        return Colors.orange[300];
      case 2:
        return Colors.red[300];
      case 3:
        return Colors.green[300];
      case 4:
        return Colors.brown[300];
    }
  }

  String getImage(int index) {
    switch (index) {
      case 0:
        return "images/apostila1.webp";
      case 1:
        return "images/apostila2.webp";
      case 2:
        return "images/apostila3.webp";
      case 3:
        return "images/apostila4.webp";
      case 4:
        return "images/apostila5.webp";
    }
  }

  String getTitle(int index) {
    switch (index) {
      case 0:
        return "Princípios Elementares";
      case 1:
        return "O Propósito Eterno";
      case 2:
        return "Vida em Cristo";
      case 3:
        return "Comunhão com Deus";
      case 4:
        return "Evangelho do Reino";
    }
  }
}
