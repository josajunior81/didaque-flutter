import 'dart:async';

import 'package:didaque_flutter/apostilas.dart';
import 'package:didaque_flutter/app_icons.dart';
import 'package:didaque_flutter/inicio.dart';
import 'package:didaque_flutter/leitor_biblia.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runZonedGuarded(() {
    runApp(DidaqueApp());
  }
  , FirebaseCrashlytics.instance.recordError);

}
FirebaseAnalytics analytics = FirebaseAnalytics();

/// This Widget is the main application widget.
class DidaqueApp extends StatelessWidget {
  static const String _title = 'Didaquê';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(fontFamily: 'Montserrat'),
      home: Home(),
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics),
      ],
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
  final List<Widget> _children = [InicioStatefullWidget(), Text("Biblia"), ApostilasWidget()];

  void onTabTapped(int index) {
    setState(() {
      if (index == 1) {
        _currentIndex = 0;
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return LeitorBibliaStatefulWidget();
        }));
      } else {
        _currentIndex = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Didaquê',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: Image(image: AssetImage("images/icon.png")),
        backgroundColor: Colors.grey[700],
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
            icon: new Icon(Icons.home),
            title: new Text('Início'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(AppIcons.bible),
            title: new Text('Bíblia'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(AppIcons.office_25),
            title: new Text('Apostilas'),
          )
        ],
      ),
    );
  }
}
