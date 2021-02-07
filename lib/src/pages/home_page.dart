import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

//models imports
import 'package:cinenic_app/src/providers/pelicula_provider.dart';

//owner imports
import '../widgets/card_swiper_widget.dart';
import '../widgets/horizontal_slider_widget.dart';
import '../widgets/button_back_widget.dart';
import 'package:cinenic_app/src/providers/menu_provider.dart';

class HomePage extends StatelessWidget {
  final peliculas = PeliculaProvider();
  final menu = MenuProvider();
  Future<List<dynamic>> futureMenu;

  @override
  Widget build(context) {
    futureMenu = menu.getMenuData();

    return Scaffold(
        backgroundColor: const Color(0xff35495e),
        body: ListView(
          children: <Widget>[_getFinder()],
        )

        /* Container(   
        color: Colors.amber,     
        //padding: EdgeInsets.only(top: 100.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _getSwiper(),
            _populars(context)
          ],
        )
      ) */
        );
  }

  Widget _getFinder() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
      child: TextField(
        autofocus: false,
        decoration: InputDecoration(
            filled: true,
            hintText: 'Find movie, serie, actor...',
            suffixIcon: Icon(
              Icons.search,
              color: Colors.grey,
            ),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
            fillColor: Colors.grey[300],
            focusColor: Colors.red,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(30.0))),
        onChanged: (value) {},
      ),
    );
  }

  Widget _menu(context) {
    return FutureBuilder(
        future: futureMenu,
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            return Wrap(
              runSpacing: 20.0,
              children: _getButton(context, snapshot.data),
            );
          } else {
            return Container(
              height: 400.0,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }

  List<Widget> _getButton(BuildContext context, List menuItems) {
    List<Widget> listItem = [];
    final _size = MediaQuery.of(context).size;

    menuItems.forEach((item) {
      final btn = Container(
        width: _size.width * 0.5,
        child: FlatButton(
          child: Column(children: <Widget>[
            SvgPicture.asset(
              item['icon'],
              width: _size.width * 0.35,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(item['label'],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w800,
                  color: Colors.grey[800],
                ))
          ]),
          onPressed: (() {
            Navigator.pushNamed(context, item['route']);
          }),
        ),
      );

      listItem.add(btn);
    });

    return listItem;
  }

  /* Widget _getSwiper(){

    return FutureBuilder(
      future: peliculas.getNowPlaying(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot){

        if(snapshot.hasData){
          return CardSwiper(
            movies: snapshot.data
          );
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

  } */

  Widget _populars(context) {
    return Container(
        color: Colors.red,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 20.0),
              child: Text('Poulares'),
            ),
            SizedBox(height: 5.0),
            FutureBuilder(
              future: peliculas.getPopular(),
              builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                if (snapshot.hasData) {
                  return HorizontalSlider(
                    movies: snapshot.data,
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            )
          ],
        ));
  }
}

/* SvgPicture.asset(
  'assets/SVG/logo.svg',
  width: 250.0,
), 
SizedBox(height: 80.0),
_menu(context)*/
