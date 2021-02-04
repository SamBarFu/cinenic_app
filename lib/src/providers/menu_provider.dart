import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class MenuProvider {

  _MenuProvider(){
    //
  }

  Future<List<dynamic>> getMenuData() async {

    final resp = await rootBundle.loadString('data/menu.json');

    final data = json.decode(resp);

    List<dynamic> menu = data['routes'];

    return menu;

  }


}