import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import '../models/pelicula.dart';


class PeliculaProvider{

  String _apikey = '0d9d05a1d32c283ecadcef744fa2a923';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';
  String _endpoint;

  Future<List<dynamic>> getNowPlaying() async{

    _endpoint = '3/movie/now_playing';

    final url = Uri.https(_url, _endpoint, {
      'api_key' : _apikey,
      'language' : _language
    });

    final resp = await http.get(url);

    final data = json.decode(resp.body);

    final peliculas = new Peliculas.fromJsonList(data['results']);

    return peliculas.items;

  }

  Future<List<Pelicula>> getPopular() async{

    _endpoint = '3/movie/popular';

    final url = Uri.https(_url, _endpoint,  {
      'api_key' : _apikey,
      'language' : _language
    });

    final resp = await http.get(url);
    final data = json.decode(resp.body);
    final peliculas = new Peliculas.fromJsonList(data['results']);

    return peliculas.items;

  }

}