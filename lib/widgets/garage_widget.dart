import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meca_note_mobile/widgets/note_garage_widget.dart';

import 'color_widget.dart';

class GarageWidget{

  static Container garageContainer(garage,w,h, {showImage = true}) {
    return Container(
        padding: const EdgeInsets.only(
            left: 10, top: 10, bottom: 10),
        decoration: BoxDecoration(
            border: Border.all(color: ColorWidget.black12),
            color: ColorWidget.white,
            borderRadius:
            const BorderRadius.all(Radius.circular(10))),
        child: Column(
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Row(
                      children: [
                        Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(100),
                                color: Colors.black.withOpacity(0.1)),
                            child: Icon(
                              Icons.garage_outlined,
                              color: ColorWidget.blue,
                            )),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          garage["name"],
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            ),
            const SizedBox(height: 5,),
            showImage ? Image.asset("assets/img.png", width: w,height: 100,) : const SizedBox.shrink(),
            showImage ?  const SizedBox(height: 5,): const SizedBox.shrink(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NoteGarage.noteGarage(garage['note'] ?? 0),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: ColorWidget.blue,
                        size: 30,
                      ),
                      Text(_formatDistance(garage['distance'])),
                    ],
                  ),
                ),
              ],
            )
          ],
        ));
  }

  static String _formatDistance(int distance){
    if(distance.toString().length >= 4){
      return (distance / 1000).toString()+" Km";
    }
    return distance.toString()+" m";
  }

}
