import 'package:didaque_flutter/detalhe_apositla.dart';
import 'package:didaque_flutter/utils.dart';
import 'package:flutter/material.dart';

class ApostilasWidget extends StatefulWidget {
  ApostilasWidget({Key key}) : super(key: key);

  @override
  _ApostilasWidgetState createState() => _ApostilasWidgetState();
}

class _ApostilasWidgetState extends State<ApostilasWidget> {
  @override
  Widget build(BuildContext context) {
    List itens = [
      listItem(0, context),
      listItem(1, context),
      listItem(2, context),
      listItem(3, context),
      listItem(4, context)
    ];

    return ListView.builder(
        itemCount: itens.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return itens[index];
        });
  }

  void _showDetails(int index, BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ApostilaDetalhesWidget(index);
    }));
  }

  Widget listItem(int position, BuildContext context) => Hero(
        tag: position,
        child: Material(
          child: InkWell(
            onTap: () => _showDetails(position, context),
            child: Container(
              height: 150.0,
              color: Utils.getColor(position),
              child: Row(
                children: [
                  Image.asset(Utils.getImage(position)),
                  Expanded(
                    child: Center(
                      child: Text(
                        Utils.getTitle(position),
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
}
