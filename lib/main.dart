
import 'package:flutter/material.dart';
import 'package:qoutes/homepage.dart';
import 'package:qoutes/introduction.dart';
import 'package:qoutes/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minfo',
      theme: ThemeData(),
      home: FutureBuilder(
          future: _checkSharedPref(),
          builder: (context, snap) {
            if (snap.hasData) {
              if (snap.data)
                return Homepage();
              else
                return IntroPage();
            }
            return Container(
              color: white2,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }),
    );
  }

  _checkSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('isFirst') ?? false) {
      return true;
    } else {
      prefs.setBool('isFirst', true);
      return false;
    }
    //return false;
  }
}
