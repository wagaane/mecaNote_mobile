import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:meca_note_mobile/models/garage_response.dart';
import 'package:meca_note_mobile/models/service_modele.dart';
import 'package:meca_note_mobile/services/domaine_mecano_service.dart';
import 'package:meca_note_mobile/utils/utilis.dart';
import 'package:meca_note_mobile/widgets/border_radius_widget.dart';
import 'package:meca_note_mobile/widgets/color_widget.dart';
import 'package:meca_note_mobile/widgets/go_back_widget.dart';
import 'package:meca_note_mobile/widgets/title_widget.dart';

import '../../../config/api_config.dart';
import '../../../widgets/note_garage_widget.dart';


class DetailGarageMecanoScreen extends StatefulWidget {
  final garageResponse;

  const DetailGarageMecanoScreen({super.key,   this.garageResponse});

  @override
  State<DetailGarageMecanoScreen> createState() => _DetailGarageMecanoScreenState();
}

class _DetailGarageMecanoScreenState extends State<DetailGarageMecanoScreen> {
  late GarageResponse _garage;
  bool _loading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initData();
  }

  _initData()async{

    _setGarage();
    await _getServices();
    setState(() {
      _loading = false;
    });
  }

  bool _isTabServiceEnable = true;

  List<ServiceModele> _services = [];
  _getServices()async{
    var res = await GarageService.listServicesByGarageId(_garage.id);
    print('$res');
    setState(() {
      _services = ServiceModele.fromList(res['payload']);
    });
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
      body:
      SingleChildScrollView(
        child:
        Column(
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
                              SizedBox(
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
                     Row(
                      children: [
                        Text(
                          _garage.nom,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),

                    NoteGarage.noteGarage(4),

                    const SizedBox(
                      height: 10,
                    ),

                  ],
                ),
              ),
            ),
            Center(
              child: Container(
                width: W - 15,
                decoration: BoxDecoration(
                    borderRadius: BorderRadiusWidget.borderRadius10(),
                ),
                child: Column(
                  children: [
                     Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: (){
                           setState(() {
                             _isTabServiceEnable = true;
                           });
                          },
                          child: Container(
                            width: W / 2 - 15,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color:  _isTabServiceEnable ? ColorWidget.blue : Colors.white,
                                border: Border.all(color: ColorWidget.blue!),
                                borderRadius: BorderRadiusWidget.borderRadius05()
                            ),
                            child:  Text(
                              "services",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600, color: _isTabServiceEnable?  Colors.white : ColorWidget.blue ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10,),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              _isTabServiceEnable = false;
                            });
                          },
                          child: Container(
                            width: W / 2 - 20,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: !_isTabServiceEnable ? ColorWidget.blue : Colors.white,
                              border: Border.all(color: ColorWidget.blue!),
                              borderRadius: BorderRadiusWidget.borderRadius05()
                            ),
                            child: Text(
                              "commentaires",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600, color: _isTabServiceEnable ? ColorWidget.blue : Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15,),
                    _loading ? Utils.loading() :
                    SizedBox(
                      height: H /2,
                      child: !_isTabServiceEnable ?  ListView.separated(itemBuilder: (context, index) {

                        return Card(
                          color: Colors.white,
                          child: ListTile(
                            title: Text("Ablaye FAYE"),
                            subtitle: Column(
                              children: [
                                SizedBox(width: MediaQuery.of(context).size.width - 10, child: Text("hello ce garage est top est l'accueilhello ce garage est top est l'accueilhello ce garage est top est l'accueil est Waouhh."),),
                                const SizedBox(height: 10,),
                                Row(
                                  children: [
                                    Text("Note donnée : "),
                                    NoteGarage.noteGarage(2),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }, separatorBuilder: (context, index) {
                        return SizedBox(height:2,);
                      }, itemCount: 10) : ListView.builder(
                        itemCount: _services.length,
                        itemBuilder: (context, index) {
                          var service = _services[index];
                          return  Card(
                            color: Colors.white,
                            child: ListTile(
                              leading: Image.asset(service.img, width: 30, color: ColorWidget.blue,),
                              title: Text(service.label),
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
