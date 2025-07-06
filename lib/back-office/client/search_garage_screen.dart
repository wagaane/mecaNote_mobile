import 'package:flutter/material.dart';
import 'package:meca_note_mobile/back-office/client/detail_garage_screen.dart';
import 'package:meca_note_mobile/widgets/border_radius_widget.dart';
import 'package:meca_note_mobile/widgets/garage_widget.dart';
import 'package:meca_note_mobile/widgets/title_widget.dart';

import '../../widgets/color_widget.dart';
import '../../widgets/go_back_widget.dart';

class SearchGarageScreen extends StatefulWidget {
  const SearchGarageScreen({super.key});

  @override
  State<SearchGarageScreen> createState() => _SearchGarageScreenState();
}

class _SearchGarageScreenState extends State<SearchGarageScreen> {
  late List _services = [
    {
      "name": "climatisation",
      "actif": true,
    },
    {
      "name": "Plus Proche",
      "actif": false,
    },
    {
      "name": "transmission",
      "actif": false,
    },
    {
      "name": "suspension et direction",
      "actif": false,
    },
    {
      "name": "Diagnosticien",
      "actif": false,
    },
    {
      "name": "Peintre",
      "actif": false,
    },
    {
      "name": "Électricien",
      "actif": false,
    },
    {
      "name": "généraliste",
      "actif": false,
    }
  ];

  List _garages = [
    {
      "name": "Wagaane Garage",
      "note": 4,
      "distance": 30
    },{
      "name": "Touba Garage",
      "note": 3,
      "distance": 50
    },{
      "name": "Garage +221",
      "note": 1,
      "distance": 500
    },{
      "name": "Garage ndoukoumane",
      "note": 5,
      "distance": 1000
    },{
      "name": "Garage Camion",
      "note": 1,
      "distance": 2000
    },{
      "name": "Garage BMW",
      "note": 2,
      "distance": 3000
    }
  ];
  @override
  Widget build(BuildContext context) {
    var W = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(190),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GoBackWidget.goBack(context),
                    SizedBox(
                      width: W / 4,
                    ),
                    TitleWidget.setTitle("Liste Garages")
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Nom Garage',
                      labelStyle: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w100),
                      border: OutlineInputBorder(
                        // Default border
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        // When not focused
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(color: Colors.grey.withOpacity(0.4)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        // When focused (clicked)
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            color: ColorWidget.blue!.withOpacity(0.4),
                            width: 2),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: W,
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child:
                    ListView.separated(
                      itemCount: _services.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (
                          BuildContext context,
                          int index,
                          ) {
                        var service = _services[index];
                        return GestureDetector(
                          onTap: () {
                            var services = [];
                            for (var element in _services) {
                              if(element == service){
                                element['actif'] = true;
                                services.add(element);
                              }else{
                                element['actif'] = false;
                                services.add(element);
                              }
                              setState(() {
                                _services = services;
                              });
                            }},
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(color: ColorWidget.blue!),
                                color: service['actif'] ? ColorWidget.blue : ColorWidget.white,
                                borderRadius: BorderRadiusWidget.borderRadius10()),
                            child: Center(
                                child: Text(
                                  "${service['name']}",
                                  style:  TextStyle(
                                      color: service['actif'] ? Colors.white : ColorWidget.blue, fontWeight: FontWeight.w600),
                                )),
                          ),
                        );

                      },
                      separatorBuilder: (context, index) =>
                      const SizedBox(width: 5), // or Divider()
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 2 + 210,
                child:
                ListView.builder(
                  itemCount: _garages.length,
                  itemBuilder: (context, index) {
                    var garage = _garages[index];
                    return GestureDetector(
                        onTap: () {
                          Navigator.push<void>(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  const DetailGarageScreen(),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            GarageWidget.garageContainer(
                                garage,MediaQuery.of(context).size.width,MediaQuery.of(context).size.height)
                          ],
                        ));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
