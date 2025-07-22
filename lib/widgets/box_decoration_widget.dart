import 'package:flutter/cupertino.dart';
import 'package:meca_note_mobile/widgets/border_radius_widget.dart';

class BoxDecorationWidget{
  static  BoxDecoration box(color,){
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadiusWidget.borderRadius10()
    );
}
}