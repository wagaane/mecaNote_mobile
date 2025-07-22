import 'package:flutter/material.dart';
import 'package:meca_note_mobile/back-office/mecanicien/garages/list_garage_screen.dart';

import '../../widgets/border_radius_widget.dart';
import '../../widgets/box_decoration_widget.dart';
import '../../widgets/color_widget.dart';
import 'mecanos/list_mecanos_screen.dart';
class HomeMecano extends StatelessWidget {
  const HomeMecano({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                //   Mes garages

                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const ListGarageScreen(),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                height: MediaQuery.of(context).size.height / 4,
                width: MediaQuery.of(context).size.width / 2 - 20,
                decoration: BoxDecorationWidget.box(Colors.white),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/mechanic.png',
                      width: 50,
                      color: ColorWidget.blue,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Mes Garages",
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    Container(
                      width: 35,
                      height: 35,
                      // padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: ColorWidget.blue,
                        borderRadius: BorderRadiusWidget.borderRadius100()
                      ),
                      child: Center(child: Text("30", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),)),
                    )
                  ],
                ),
              ),
            ),

            GestureDetector(
              onTap: () {
                //   Mes garages
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                height: MediaQuery.of(context).size.height / 4,
                width: MediaQuery.of(context).size.width / 2 - 20,
                decoration: BoxDecorationWidget.box(Colors.white),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Image.asset(
                      'assets/icons/services.png',
                      width: 50,
                      color: ColorWidget.blue,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Mes Services",
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    Container(
                      width: 35,
                      height: 35,
                      // padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: ColorWidget.blue,
                          borderRadius: BorderRadiusWidget.borderRadius100()
                      ),
                      child: Center(child: Text("30", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),)),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                //   Mes garages
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                height: MediaQuery.of(context).size.height / 4,
                width: MediaQuery.of(context).size.width / 2 - 20,
                decoration: BoxDecorationWidget.box(Colors.white),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.waterfall_chart_outlined,
                      size: 50,
                      color: ColorWidget.blue,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Statistiques",
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),

                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                //   Mes garages
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                height: MediaQuery.of(context).size.height / 4,
                width: MediaQuery.of(context).size.width / 2 - 20,
                decoration: BoxDecorationWidget.box(Colors.white),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/team.png',
                      width: 50,
                      color: ColorWidget.blue,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Rdvs",
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    Container(
                      width: 35,
                      height: 35,
                      // padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: ColorWidget.blue,
                          borderRadius: BorderRadiusWidget.borderRadius100()
                      ),
                      child: Center(child: Text("30", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),)),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                //   Mes garages
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push<void>(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) => const ListMecanosScreen(),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          width: MediaQuery.of(context).size.width / 2 - 20,
                          height: MediaQuery.of(context).size.width / 2 - 10,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadiusWidget.borderRadius10()),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/icons/people.png",
                                width: 50,
                                color: ColorWidget.blue,
                              ),
                              const Text(
                                "Mes Mécanos",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                              Container(
                                width: 35,
                                height: 35,
                                // padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: ColorWidget.blue,
                                    borderRadius: BorderRadiusWidget.borderRadius100()
                                ),
                                child: Center(child: Text("30", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),)),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        width: MediaQuery.of(context).size.width / 2 - 20,
                        height: MediaQuery.of(context).size.width / 2 - 10,
                        decoration: BoxDecoration(
                            color: ColorWidget.white,
                            borderRadius:
                            BorderRadiusWidget.borderRadius10()),
                        child:  Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.comment_outlined,
                              size: 50,
                              color: ColorWidget.blue,
                            ),
                            const Text(
                              "Récent",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            const Text(
                              "Avis & Feedback",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            Container(
                              width: 35,
                              height: 35,
                              // padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: ColorWidget.blue,
                                  borderRadius: BorderRadiusWidget.borderRadius100()
                              ),
                              child: const Center(child: Text("30", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),)),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
