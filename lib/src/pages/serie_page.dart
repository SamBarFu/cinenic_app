import 'package:flutter/material.dart';

import 'package:cinenic_app/src/providers/serie_provider.dart';
import '../widgets/horizontal_slider_widget.dart';

class Serie extends StatelessWidget {
  final serieProvider = SerieProvider();

  @override
  Widget build(BuildContext context) {
    serieProvider.getSeries();
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
            stream: serieProvider.streamSerie,
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
