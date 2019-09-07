import 'package:flutter/material.dart';

class ApostilasStatefulWidget extends StatefulWidget {
  ApostilasStatefulWidget({Key key}) : super(key: key);

  @override
  _ApostilasStatefulWidgetState createState() => _ApostilasStatefulWidgetState();
}

class _ApostilasStatefulWidgetState extends State<ApostilasStatefulWidget> {

  @override
  Widget build(BuildContext context) {
    Widget listItem(Color color, String title, String image) => Container(
      height: 150.0,
      color: color,
      child: Row(
        children: [
          Image.asset(image
          ),
          Expanded(
            child: Center(
              child: Text(
                "$title",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
        ],
      ),
    );

    Color getColor(int index){
      switch(index) {
        case 0: return Colors.blueGrey[300];
        case 1: return Colors.orange[200];
        case 2: return Colors.red[300];
        case 3: return Colors.green[300];
        case 4: return Colors.blue[300];
      }
    }

    String getImage(int index){
      switch(index) {
        case 0: return "images/apostila1.webp";
        case 1: return "images/apostila2.webp";
        case 2: return "images/apostila3.webp";
        case 3: return "images/apostila4.webp";
        case 4: return "images/apostila5.webp";
      }
    }

    String getTitle(int index){
      switch(index) {
        case 0: return "Princípios Elementares";
        case 1: return "O Propósito Eterno";
        case 2: return "Vida em Cristo";
        case 3: return "Comunhão com Deus";
        case 4: return "Evangelho do Reino";
      }
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
//          SliverAppBar(
//            expandedHeight: 200.0,
//            floating: false,
//            pinned: true,
//            flexibleSpace: FlexibleSpaceBar(
//                centerTitle: true,
//                title: Text("Didaquê",
//                    style: TextStyle(
//                      color: Colors.white,
//                      fontSize: 16.0,
//                    )),
//                background: Image.asset(
//                  "images/top.jpg",
//                  fit: BoxFit.cover,
//                )
//            ),
//          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                if (index > 4) return null;
                return listItem(getColor(index), getTitle(index), getImage(index));
              },
            ),
          )
        ],
      ),
    );
  }
}