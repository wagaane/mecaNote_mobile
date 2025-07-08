import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'color_widget.dart';

class MyButtonWidget{
  static GestureDetector goBack(context){
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.only(left: 10, bottom: 10),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(100)),
            color: ColorWidget.blue?.withOpacity(0.1)),
        child: const Icon(Icons.arrow_back),
      ),
    );
  }

  static Container paddingIcon(icon){
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(left: 10, bottom: 10),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(100)),
          color: ColorWidget.blue?.withOpacity(0.1)),
      child: icon,
    );
  }
}