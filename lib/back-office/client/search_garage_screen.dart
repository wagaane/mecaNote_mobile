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
  @override
  Widget build(BuildContext context) {
    var W = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),

      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(130),
        child:
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GoBackWidget.goBack(context),
                        SizedBox(width: W / 4,),
                        TitleWidget.setTitle("Liste Garages")

                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Nom Garage',
                          labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w100),
                          border: OutlineInputBorder( // Default border
                            borderRadius: BorderRadius.circular(12),
                          ),
                          enabledBorder: OutlineInputBorder( // When not focused
                            borderRadius: BorderRadius.circular(12),
                            borderSide:  BorderSide(color: Colors.grey.withOpacity(0.4)),
                          ),
                          focusedBorder: OutlineInputBorder( // When focused (clicked)
                            borderRadius: BorderRadius.circular(12),
                            borderSide:  BorderSide(color: ColorWidget.blue!.withOpacity(0.4), width: 2),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),

        ),

      body:  SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10,),
            SizedBox(
              width: W,
              height: 50,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [

                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: ColorWidget.blue,
                        borderRadius: BorderRadiusWidget.borderRadius10()
                      ),
                      child: Center(child: Text("Plus proches", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),)),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          color: ColorWidget.blackWithOpacityO5.withOpacity(0.3),
                          borderRadius: BorderRadiusWidget.borderRadius10()
                      ),
                      child: Center(child: Text("Mieux notés", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),)),
                    ),Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          color: ColorWidget.blackWithOpacityO5.withOpacity(0.3),
                          borderRadius: BorderRadiusWidget.borderRadius10()
                      ),
                      child: Center(child: Text("généraliste", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),)),
                    ),Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          color: ColorWidget.blackWithOpacityO5.withOpacity(0.3),
                          borderRadius: BorderRadiusWidget.borderRadius10()
                      ),
                      child: Center(child: Text("Électricien", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),)),
                    ),Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          color: ColorWidget.blackWithOpacityO5.withOpacity(0.3),
                          borderRadius: BorderRadiusWidget.borderRadius10()
                      ),
                      child: Center(child: Text("climatisation", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),)),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(itemCount: 15,itemBuilder: (context, index) {
                  return GestureDetector(onTap: () {
        
                    Navigator.push<void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => const DetailGarageScreen(),
                      ),
                    );
                  },child: Column(
                    children: [
        
                      GarageWidget.garageContainer({"name":"Garage Touba"}),
                    ],
                  ));
                },),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
