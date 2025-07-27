import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:meca_note_mobile/back-office/map_screen.dart';
import 'package:meca_note_mobile/models/garage_response.dart';
import 'package:meca_note_mobile/utils/phone_number_call.dart';
import 'package:meca_note_mobile/utils/whatsappp_contact_utils.dart';
import 'package:meca_note_mobile/widgets/border_radius_widget.dart';
import 'package:meca_note_mobile/widgets/color_widget.dart';
import 'package:meca_note_mobile/widgets/go_back_widget.dart';
import 'package:meca_note_mobile/widgets/title_widget.dart';

import '../../config/api_config.dart';
import '../../widgets/note_garage_widget.dart';

class DetailGarageScreen extends StatefulWidget {
  final garageResponse;
  const DetailGarageScreen({super.key,   this.garageResponse});

  @override
  State<DetailGarageScreen> createState() => _DetailGarageScreenState();
}

class _DetailGarageScreenState extends State<DetailGarageScreen> {
  late GarageResponse _garage;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setGarage();
  }
  
  _setGarage(){
    setState(() {
      _garage = widget.garageResponse;
    });
  }
  @override
  Widget build(BuildContext context) {
    var H = MediaQuery.of(context).size.height;
    var W = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      appBar: AppBar(
        title: TitleWidget.setTitle("Détails du garage"),
        leading: MyButtonWidget.goBack(context),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.all(30),
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadiusWidget.borderRadius10(),
                    color: Colors.white),
                child: Column(
                  children: [
                    CachedNetworkImage(
                      width: MediaQuery.of(context)
                          .size
                          .width,
                      height: 150,
                      imageUrl:
                      "${ApiConfig.baseUrl}file/download?filename=${_garage.file?.generatedName}",
                      imageBuilder:
                          (context, imageProvider) =>
                          Container(
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadiusWidget
                                  .borderRadius05(),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                      placeholder: (context, url) =>
                          Column(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              Container(
                                  width: MediaQuery.of(
                                      context)
                                      .size
                                      .width /
                                      4,
                                  height: MediaQuery.of(
                                      context)
                                      .size
                                      .width /
                                      4,
                                  child:
                                  CircularProgressIndicator(
                                    color:
                                    ColorWidget.blue,
                                  )),
                            ],
                          ),
                      errorWidget:
                          (context, url, error) =>
                      const Icon(Icons.error),
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    const Row(
                      children: [
                        Text(
                          "Garage Touba",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: ColorWidget.blue,
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width /2, child: const Text(
                          "105, Birago Diop Point e, Dakar",
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),)
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.route,
                          color: ColorWidget.blue,
                        ),
                        const Text(
                          "105 m",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    NoteGarage.noteGarage(1),
        
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            showModalBottomSheet(
                              context: context,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20)),
                              ),
                              builder: (context) {
                                return Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text('Contacter Garage',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600)),
                                        ListTile(
                                          leading: const Icon(Icons.call),
                                          title: const Text('Téléphone'),
                                          onTap: () async {
                                            await PhoneNumberCall.makePhoneCall(
                                                "+221" + "778545382");
                                            // Call function here
                                          },
                                        ),
                                        ListTile(
                                          leading: Image.asset(
                                            "assets/whatsapp.png",
                                            width: 30,
                                            color: Colors.green,
                                          ),
                                          title: const Text('WhatsApp'),
                                          onTap: () async {
                                            await WhatsAppContactUtils
                                                .openWhatsAppChat('221771234567',
                                                    'Hello, I need help with your service!');
        
                                            // Call function here
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            width: W / 2 - 65,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black.withOpacity(0.3)),
                                borderRadius:
                                    BorderRadiusWidget.borderRadius10()),
                            child: const Center(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Contacter"),
                              ],
                            )),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push<void>(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>  MapScreen(),
                              ),
                            );
                          },
                          child: Container(
                            width: W / 2 - 65,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black.withOpacity(0.3)),
                                borderRadius:
                                    BorderRadiusWidget.borderRadius10()),
                            child: const Center(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Voir itinéraire",
                                ),
                              ],
                            )),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: Container(
                width: W - 60,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadiusWidget.borderRadius10(),
                    color: Colors.white),
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text(
                            "Les services disponibles",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: H / 5,
                      child: ListView.builder(
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return const Card(
                            elevation: 0.1,
                            color: Colors.white,
                            child: ListTile(
                              title: Text("Mécanicien automobile généraliste"),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
