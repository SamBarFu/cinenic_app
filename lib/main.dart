import 'package:flutter/material.dart';

//pages import
import 'src/pages/home_page.dart';
import 'src/pages/now_playing_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => HomePage(),
        'now_playing': (BuildContext context) => NowPlaying(),
        'series': (BuildContext context) => NowPlaying(),
        'popular': (BuildContext context) => NowPlaying(),
        'upcomming': (BuildContext context) => NowPlaying()
      },
    );
  }
}
