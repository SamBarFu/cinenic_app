import 'package:flutter/material.dart';
import '../widgets/card_swiper_widget.dart';
import '../widgets/horizontal_slider_widget.dart';

//model import
import 'package:cinenic_app/src/providers/pelicula_provider.dart';

class NowPlaying extends StatelessWidget {
  final peliculas = PeliculaProvider();

  @override
  Widget build(BuildContext context) {
    peliculas.getNowPlaying();
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
            child: Text(
              'Now Playing',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: Colors.white60),
            ),
          ),
          StreamBuilder(
            stream: peliculas.streamMovie,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.hasData) {
                return HorizontalSlider(movies: snapshot.data);
              } else {
                return Container(
                  height: 200.0,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
