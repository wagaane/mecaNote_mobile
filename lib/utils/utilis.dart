import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/border_radius_widget.dart';
import '../widgets/color_widget.dart';

class Utils{

  static Widget ProfilWidget(){
    return Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.blue.withValues(alpha: 0.1),
            borderRadius: BorderRadiusWidget.borderRadius100(),
          border: Border.all(color: ColorWidget.blue!, width: 2)
        ),
        child:  Icon(Icons.person_outline, size: 35, color: ColorWidget.blue,));
  }
}