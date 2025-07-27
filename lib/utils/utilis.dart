import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

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

  static Center loading() {
    return Center(
        child: LoadingAnimationWidget.discreteCircle(
            secondRingColor: ColorWidget.white,
            size: 70,
            thirdRingColor: ColorWidget.blue!,
            color: Colors.blue));
  }
}