import 'package:flutter/material.dart';
import '../widgets/card_swiper_widget.dart';
import '../widgets/horizontal_slider_widget.dart';

//model import
import 'package:cinenic_app/src/providers/pelicula_provider.dart';

class NowPlaying extends StatelessWidget {
  final peliculas = PeliculaProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xff2a3a4a), title: Text('Now Playing')),
      body: Container(
          color: const Color(0xff35495e),
          //padding: EdgeInsets.only(top: 100.0),
          child: ListView(
            children: <Widget>[
              //CardSwiper();
              _getMovies(),
            ],
          )),
    );
  }

  Widget _getMovies() {
    return FutureBuilder(
      future: peliculas.getNowPlaying(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return HorizontalSlider(movies: snapshot.data);
        } else {
          return Container(
            height: 400.0,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
