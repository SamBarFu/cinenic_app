import 'package:flutter/material.dart';

//flutter dependencies
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

//model import
import 'package:cinenic_app/src/models/pelicula.dart';
import 'package:cinenic_app/src/providers/pelicula_provider.dart';

//widget import
import 'categories_widget.dart';


class CardSwiper extends StatefulWidget{

  @override 
  _CardSwiperState createState() => _CardSwiperState();

}

class _CardSwiperState extends State<CardSwiper>{

  //CardSwiper({@required this.movies});
  
  final peliculas = PeliculaProvider(); 
  List<Pelicula> movies;
  int indexMovie = 0;

  List<String> categories = ['Drama', 'Comedy', 'War'];

  @override 
  Widget build(BuildContext context){

    return FutureBuilder(
      future: peliculas.getNowPlaying(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot){

        if(snapshot.hasData){
          movies = snapshot.data;
          return _getSwiper();
        }else{
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

  Widget _getSwiper(){

    final _screenSize = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          Swiper(
            layout: SwiperLayout.TINDER,
            itemBuilder: (BuildContext context, int i){
              return _getCardImage(i);
            },
            itemWidth: _screenSize.width,
            itemHeight: _screenSize.height * 0.8,
            itemCount: movies.length,
            onIndexChanged: (index) {
              setState(() {
                indexMovie = index;
                //currentMovie = movies[index];
              });
            },
          ),
          Positioned(
            top: _screenSize.height * 0.74,
            bottom: -800,
            child: _getDescription(),
          )          
        ]
      )
    );
  }

  Widget _getCardImage(int index){

    final _screenSize = MediaQuery.of(context).size;

    return Container(
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: FadeInImage(
                image: NetworkImage(movies[index].getPosterImage()),
                placeholder: AssetImage('assets/img/loading.gif'),
                fit: BoxFit.cover,
                height: _screenSize.height * 0.8,
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: Container(
                  color: Colors.black54,
                  child: _infoCardMovie(index)
                ),
              )
            ),
            //_infoCardMovie(index)

          ],
      ),
    );

  }

  Widget _infoCardMovie(int index){

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Categories(listCategories: categories),
        _getTitle(),
        _getFooter(index),
      ],
    );

  }

  Widget _getTitle(){

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.calendar_today,
                size: 30.0,
                color: Colors.white
              ),
              SizedBox(width: 10.0),
              Text(movies[indexMovie].releaseDate,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ]
          ),
          SizedBox(height: 20.0),
          Text(movies[indexMovie].title,
            style: TextStyle(
              fontSize: 50.0,
              color: Colors.white,
              fontWeight: FontWeight.w800
            ),
          ),        
        ]
      ),
    );

  }

  Widget _getFooter(index){

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Icon(
              Icons.play_circle_filled,
              size: 85.0,
              color: Colors.white,
            ),
          ),
          Column(
            children: [             
              Text(movies[index].voteAverage.toString(),
                style: TextStyle(
                  color: Colors.grey[50],
                  fontSize: 50.0,
                  fontWeight: FontWeight.w800
                ),
              ),
              RatingBarIndicator(
                rating: movies[index].voteAverage/2,
                itemBuilder: (context, i) => Icon(
                    Icons.star,
                    color: Colors.amber,
                ),
                itemCount: 5,
                itemSize: 35.0,
                direction: Axis.horizontal,
                unratedColor: Colors.grey[900],
              ),
            ],
          ),
        ]
      )
    );

  }

  Widget _getDescription(){

    final _screenSize = MediaQuery.of(context).size;

    return ClipRRect(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(50.0), topRight: Radius.circular(50.0)),
      child: Container(
      color: Colors.white,
      width: _screenSize.width,
      height: _screenSize.height * 0.8,
      child: Column(
        children: <Widget>[
          Text(movies[indexMovie].overview),
        ],
      )
    ),
    );
     
  }

}