import 'package:flutter/material.dart';

//page imports
import '../pages/home_page.dart';
import '../pages/now_playing_page.dart';

//pages imports

Map<String, WidgetBuilder> getAppRoutes(){

  return <String, WidgetBuilder>{
    '/': (BuildContext context) => HomePage(),
    'now_playing': (BuildContext context) => NowPlaying()
  };

}

MaterialPageRoute getRouteDefault(){

  return MaterialPageRoute(
    builder: (context) => HomePage()
  );

}


