import 'package:animu/screens/root.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(Animu());

class Animu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Animu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Root(),
      },
    );
  }
}
