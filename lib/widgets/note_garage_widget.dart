import 'package:flutter/material.dart';
class NoteGarage {

  static Row noteGarage(int note){
    if(note > 5){
      note = 5;
    }
    List<Icon> icons = [];
    for(var i = 0; i < note; i++){
      icons.add(Icon(Icons.star, color: Colors.orange,),);
    }
    for(var i = note; i < 5; i++){
      icons.add(Icon(Icons.star_border_outlined, color: Colors.orange,),);
    }
    return  Row(
      children: icons.map((e) {
        return e;
      },).toList()
    );
  }


}