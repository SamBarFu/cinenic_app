import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import '../models/pelicula.dart';

class PeliculaProvider {
  String _apikey = '0d9d05a1d32c283ecadcef744fa2a923';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';
  String _endpoint;
  int _page = 0;

  List<Pelicula> _movies = new List();

  final _streamControllerMovie = StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get sinkMovie => _streamControllerMovie.sink.add;

  Stream<List<Pelicula>> get streamMovie => _streamControllerMovie.stream;

  void dispose() {
    _streamControllerMovie?.close();
  }

  Future<List<dynamic>> getNowPlaying() async {
    _endpoint = '3/movie/now_playing';
    _page++;

    final uri = Uri.https(_url, _endpoint,
        {'api_key': _apikey, 'language': _language, 'page': _page.toString()});

    final resp = await getResp(uri);

    sinkMovie(resp);

    return resp;
  }

  Future<List<Pelicula>> getPopular() async {
    _endpoint = '3/movie/popular';
    _page++;

    final uri = Uri.https(_url, _endpoint,
        {'api_key': _apikey, 'language': _language, 'page': _page.toString()});

    final resp = await getResp(uri);

    _movies.addAll(resp);

    sinkMovie(_movies);

    return resp;
  }

  Future<List<Pelicula>> getResp(Uri uri) async {
    final resp = await http.get(uri);
    final data = json.decode(resp.body);
    final peliculas = new Peliculas.fromJsonList(data['results']);

    return peliculas.items;
  }
}
