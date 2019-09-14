import 'package:didaque_flutter/apostilas.dart';
import 'package:didaque_flutter/app_icons.dart';
import 'package:didaque_flutter/biblia.dart';
import 'package:didaque_flutter/custom_icons.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

void main() {
  Crashlytics.instance.enableInDevMode = true;

  FlutterError.onError = Crashlytics.instance.recordFlutterError;

  runApp(DidaqueApp());
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
  final List<Widget> _children = [BibliaStatefulWidget(), ApostilasWidget()];

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
