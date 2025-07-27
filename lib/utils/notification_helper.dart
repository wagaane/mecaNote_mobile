import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meca_note_mobile/widgets/color_widget.dart';

class NotificationHelper{


  static success(BuildContext context, msg){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg, style: TextStyle(color: ColorWidget.white,fontSize: 16),),
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.blue[900],
      ),
    );
  }

  static error(BuildContext context, msg){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg, style: TextStyle(color: ColorWidget.white,fontSize: 16),),
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.red[900],
      ),
    );
  }
  static warning(BuildContext context, msg){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg, style: TextStyle(color: ColorWidget.blue,fontSize: 16),),
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.yellow[300],
      ),
    );
  }
}
