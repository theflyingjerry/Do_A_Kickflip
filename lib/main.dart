import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:skate_trick_selector/home.dart';
import 'package:skate_trick_selector/settings.dart';
import 'package:skate_trick_selector/loading.dart';
import 'package:skate_trick_selector/enterPage.dart';
import 'package:skate_trick_selector/history.dart';

void main() {
  runApp(Phoenix(
    child: MaterialApp(initialRoute: '/', routes: {
      '/': (context) => Loading(),
      '/home': (context) => TrickListSelect(),
      '/settings': (context) => SettingPage(),
      '/enter': (context) => EnterPage(),
      '/history': (context) => History(),
    }),
  ));
}
