import 'dart:ui';

import 'package:flutter/cupertino.dart';

import 'color_widget.dart';

class TitleWidget{
  static Text setTitle(tilte){
    return Text("$tilte", style: TextStyle(fontSize: 18,color: ColorWidget.blue, fontWeight: FontWeight.w600),);
  }
}