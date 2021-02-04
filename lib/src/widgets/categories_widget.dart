import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Categories extends StatelessWidget{

  final List<String> listCategories;

  Categories({@required this.listCategories});
  

  @override 
  Widget build(BuildContext context){

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: _getListCategories()
      ),
    );

  }

  List<Widget> _getListCategories(){

    List<Widget> widgetListCategories = List();

    listCategories.forEach((element) {
      Widget widgetTemp = ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Container(
          padding: EdgeInsets.all(10.0),
          color: Colors.white24,
          child: Text(element,
            style: TextStyle(
              color: Colors.grey[50],
              fontSize: 22.0
            ),
          )
        ),
      );
      widgetListCategories..add(widgetTemp)..add(SizedBox(width:10.0));
    });
     
    return widgetListCategories;
  }

}