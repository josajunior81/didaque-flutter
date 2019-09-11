import 'package:didaque_flutter/apostilas.dart';
import 'package:didaque_flutter/biblia.dart';
import 'package:flutter/material.dart';

void main() => runApp(DidaqueApp());

/// This Widget is the main application widget.
class DidaqueApp extends StatelessWidget {
  static const String _title = 'Didaquê';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(fontFamily: 'Montserrat'),
      home: ApostilasWidget(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [ApostilasWidget(), BibliaStatefulWidget()];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Didaquê',
          style: TextStyle(fontFamily: 'GFS Didot'),
        ),
        backgroundColor: Colors.grey[100],
      ),
      body: Center(
        child: _children[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.note),
            title: new Text('Apostilas'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.book),
            title: new Text('Bíblia'),
          )
        ],
      ),
    );
  }
}
