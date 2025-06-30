import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'color_widget.dart';

class LoadingWidget {
  static Future<dynamic> buildShowModalBottomSheet(BuildContext context,
      {isScrollControlled = false,
      displayText = "Chargement ...",
      progressColor = Colors.blue}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: isScrollControlled,
      backgroundColor: Colors.white
          .withOpacity(0), // Optional for rounded corners or custom design
      builder: (context) => Container(
          height: MediaQuery.of(context).size.height, // Full height
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: progressColor),
              Text(
                displayText,
                style: TextStyle(color: progressColor),
              )
            ],
          ))),
    );
  }

  static Future<dynamic> addActivity(BuildContext context, data,
      {isScrollControlled = false,
      displayText = "Chargement ...",
      progressColor = Colors.blue}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: isScrollControlled,
      backgroundColor: Colors.white
          .withOpacity(0), // Optional for rounded corners or custom design
      builder: (context) => Container(
          height: MediaQuery.of(context).size.height / 2, // Full height
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text("Ajouter/retier domaine(e) d'activité(s).", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      var service = data[index];
                      return GestureDetector(
                        child: Column(

                          children: [

                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 15,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.orange.withOpacity(0.5)),
                                color: Colors.white.withOpacity(0.7),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // service['image'] != ''
                                    //     ? Image.asset(service['img'],
                                    //         fit: BoxFit.contain,
                                    //         color: Colors.orange[600])
                                    //     : const Center(),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          child: AutoSizeText(
                                            service['label'],
                                            style: TextStyle(
                                                color: ColorWidget.blue,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                            maxLines: 2,
                                          ),
                                        ),
                                      ],
                                    ),
                                    GestureDetector(
                                        child:  Icon(
                                      Icons.check_box_outline_blank,
                                      color: ColorWidget.blue,
                                    ))
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
