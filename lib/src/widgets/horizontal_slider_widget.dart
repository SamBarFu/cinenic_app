import 'package:cinenic_app/src/models/pelicula.dart';
import 'package:flutter/material.dart';

class HorizontalSlider extends StatelessWidget{

  final List<Pelicula> movies;

  HorizontalSlider({@required this.movies});

  @override 
  Widget build(BuildContext context){

    final _screenSize = MediaQuery.of(context).size;

    return Container(
      height: _screenSize.height * 0.2,
      child: PageView(
        pageSnapping: false,
        children: _getMovies(context) 
        //_getMovies(context)
      ),
    );

  }

  List<Widget> _getMovies(context){

    List<Widget> wid =  movies.map((movie) { 
      return Container(
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/loading.gif'), 
                image: NetworkImage(movie.getPosterImage(),),
                height: 130,
                fit: BoxFit.cover,
              ),
            )
          ]
        ),
      );
    }).toList();

    print(wid);

    return wid;

  }
 
}