import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//model omport
import '../models/serie.dart';

class SerieProvider {
  String _apikey = '0d9d05a1d32c283ecadcef744fa2a923';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';
  String _endpoint;
  int _page = 0;

  List<Serie> _series = new List();

  final _streamControllerSerie = StreamController<List<Serie>>.broadcast();

  Function(List<Serie>) get sinkSerie => _streamControllerSerie.sink.add;

  Stream<List<Serie>> get streamSerie => _streamControllerSerie.stream;

  void dispose() {
    _streamControllerSerie?.close();
  }

  Future<List<Serie>> getSeries() async {
    _endpoint = '3/tv/popular';
    _page++;

    final uri = Uri.https(_url, _endpoint,
        {'api_key': _apikey, 'languaje': _language, 'page': _page.toString()});

    final resp = await getResp(uri);

    _series.addAll(resp);

    sinkSerie(_series);

    return resp;
  }

  Future<List<Serie>> getResp(Uri uri) async {
    final resp = await http.get(uri);
    final data = json.decode(resp.body);
    final tv = new Series.fromJsonList(data['results']);

    return tv.items;
  }
}
